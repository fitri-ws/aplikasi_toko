// API Configuration
const API_URL = 'http://localhost:5000/api';

// State Management
let currentUser = null;
let authToken = null;
let allProducts = [];
let cart = [];

// Initialize App
document.addEventListener('DOMContentLoaded', () => {
    initializeApp();
    setupEventListeners();
    checkAuthStatus();
});

// Initialize Application
async function initializeApp() {
    await loadProducts();
    await loadRecommendations('overall');
    setupFilters();
}

// Setup Event Listeners
function setupEventListeners() {
    // Navigation
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            e.target.classList.add('active');
            const target = e.target.getAttribute('href');
            document.querySelector(target).scrollIntoView({ behavior: 'smooth' });
        });
    });

    // Login/Register Buttons
    document.getElementById('loginBtn')?.addEventListener('click', () => openModal('loginModal'));
    document.getElementById('registerBtn')?.addEventListener('click', () => openModal('registerModal'));
    document.getElementById('logoutBtn')?.addEventListener('click', logout);
    document.getElementById('cartBtn')?.addEventListener('click', () => {
        if (!authToken) {
            alert('Silakan login terlebih dahulu');
            openModal('loginModal');
            return;
        }
        loadCart();
        openModal('cartModal');
    });

    // Forms
    document.getElementById('loginForm')?.addEventListener('submit', handleLogin);
    document.getElementById('registerForm')?.addEventListener('submit', handleRegister);

    // Recommendation Filters
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            e.target.classList.add('active');
            const criteria = e.target.getAttribute('data-criteria');
            loadRecommendations(criteria);
        });
    });

    // Product Filters
    document.getElementById('brandFilter')?.addEventListener('change', filterProducts);
    document.getElementById('priceFilter')?.addEventListener('change', filterProducts);
    document.getElementById('sortFilter')?.addEventListener('change', filterProducts);

    // Navbar Scroll Effect
    window.addEventListener('scroll', () => {
        const navbar = document.getElementById('navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
}

// Authentication
function checkAuthStatus() {
    const token = localStorage.getItem('authToken');
    const user = localStorage.getItem('currentUser');

    if (token && user) {
        authToken = token;
        currentUser = JSON.parse(user);
        updateUIForLoggedInUser();
    }
}

async function handleLogin(e) {
    e.preventDefault();

    const username = document.getElementById('loginUsername').value;
    const password = document.getElementById('loginPassword').value;

    try {
        const response = await fetch(`${API_URL}/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });

        const data = await response.json();

        if (response.ok) {
            authToken = data.token;
            currentUser = data.user;
            localStorage.setItem('authToken', authToken);
            localStorage.setItem('currentUser', JSON.stringify(currentUser));

            updateUIForLoggedInUser();
            closeModal('loginModal');

            // Redirect to dashboard if admin
            if (currentUser.role === 'admin') {
                window.location.href = 'dashboard.html';
            }
        } else {
            alert(data.message || 'Login gagal');
        }
    } catch (error) {
        console.error('Login error:', error);
        alert('Terjadi kesalahan saat login');
    }
}

async function handleRegister(e) {
    e.preventDefault();

    const full_name = document.getElementById('registerFullName').value;
    const username = document.getElementById('registerUsername').value;
    const email = document.getElementById('registerEmail').value;
    const password = document.getElementById('registerPassword').value;

    try {
        const response = await fetch(`${API_URL}/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ full_name, username, email, password })
        });

        const data = await response.json();

        if (response.ok) {
            alert('Registrasi berhasil! Silakan login.');
            closeModal('registerModal');
            openModal('loginModal');
        } else {
            alert(data.message || 'Registrasi gagal');
        }
    } catch (error) {
        console.error('Register error:', error);
        alert('Terjadi kesalahan saat registrasi');
    }
}

function logout() {
    authToken = null;
    currentUser = null;
    localStorage.removeItem('authToken');
    localStorage.removeItem('currentUser');

    document.getElementById('loginBtn').style.display = 'block';
    document.getElementById('registerBtn').style.display = 'block';
    document.getElementById('userMenu').style.display = 'none';

    alert('Logout berhasil');
}

function updateUIForLoggedInUser() {
    document.getElementById('loginBtn').style.display = 'none';
    document.getElementById('registerBtn').style.display = 'none';
    document.getElementById('userMenu').style.display = 'flex';
    document.getElementById('userName').textContent = currentUser.full_name;
}

// Products
async function loadProducts() {
    try {
        const response = await fetch(`${API_URL}/smartphones`);
        allProducts = await response.json();

        displayProducts(allProducts);
        populateBrandFilter();

        // Update total products count
        document.getElementById('totalProducts').textContent = allProducts.length + '+';
    } catch (error) {
        console.error('Error loading products:', error);
        document.getElementById('productsGrid').innerHTML = '<p class="loading">Gagal memuat produk</p>';
    }
}

function displayProducts(products) {
    const grid = document.getElementById('productsGrid');

    if (products.length === 0) {
        grid.innerHTML = '<p class="loading">Tidak ada produk ditemukan</p>';
        return;
    }

    grid.innerHTML = products.map(product => `
        <div class="product-card" onclick="showProductDetail(${product.id})">
            <img src="http://localhost:5000/images/${product.image_url}" 
                 alt="${product.name}" 
                 class="product-image"
                 onerror="this.src='https://via.placeholder.com/280x250?text=${encodeURIComponent(product.name)}'">
            <div class="product-content">
                <div class="product-brand">${product.brand}</div>
                <h3 class="product-name">${product.name}</h3>
                <div class="product-specs">
                    <div class="spec-item"><strong>RAM:</strong> ${product.ram}GB</div>
                    <div class="spec-item"><strong>ROM:</strong> ${product.memory}GB</div>
                    <div class="spec-item"><strong>Processor:</strong> ${product.processor}</div>
                    <div class="spec-item"><strong>Battery:</strong> ${product.battery}/10</div>
                </div>
                <div class="product-rating">
                    <span class="stars">${getStars(product.avg_rating)}</span>
                    <span class="rating-count">(${product.review_count || 0})</span>
                </div>
                <div class="product-footer">
                    <div class="product-price">Rp ${formatPrice(product.price)}</div>
                    <button class="btn-add-cart" onclick="event.stopPropagation(); addToCart(${product.id})">
                        🛒 Beli
                    </button>
                </div>
            </div>
        </div>
    `).join('');
}

async function loadRecommendations(criteria) {
    try {
        const response = await fetch(`${API_URL}/smartphones/recommendations/best?criteria=${criteria}`);
        const products = await response.json();

        const grid = document.getElementById('recommendationsGrid');
        grid.innerHTML = products.map(product => `
            <div class="product-card" onclick="showProductDetail(${product.id})">
                <img src="http://localhost:5000/images/${product.image_url}" 
                     alt="${product.name}" 
                     class="product-image"
                     onerror="this.src='https://via.placeholder.com/280x250?text=${encodeURIComponent(product.name)}'">
                <div class="product-content">
                    <div class="product-brand">${product.brand}</div>
                    <h3 class="product-name">${product.name}</h3>
                    <div class="product-specs">
                        <div class="spec-item"><strong>Performance:</strong> ${product.performance}/10</div>
                        <div class="spec-item"><strong>Camera:</strong> ${product.camera}/10</div>
                        <div class="spec-item"><strong>Battery:</strong> ${product.battery}/10</div>
                        <div class="spec-item"><strong>RAM:</strong> ${product.ram}GB</div>
                    </div>
                    <div class="product-footer">
                        <div class="product-price">Rp ${formatPrice(product.price)}</div>
                        <button class="btn-add-cart" onclick="event.stopPropagation(); addToCart(${product.id})">
                            🛒 Beli
                        </button>
                    </div>
                </div>
            </div>
        `).join('');
    } catch (error) {
        console.error('Error loading recommendations:', error);
    }
}

async function showProductDetail(id) {
    try {
        const response = await fetch(`${API_URL}/smartphones/${id}`);
        const product = await response.json();

        const detailHTML = `
            <div class="product-detail">
                <div>
                    <img src="http://localhost:5000/images/${product.image_url}" 
                         alt="${product.name}" 
                         class="product-detail-image"
                         onerror="this.src='https://via.placeholder.com/400x400?text=${encodeURIComponent(product.name)}'">
                </div>
                <div class="product-detail-info">
                    <div class="product-brand">${product.brand}</div>
                    <h2>${product.name}</h2>
                    <div class="product-detail-price">Rp ${formatPrice(product.price)}</div>
                    
                    <div class="specs-grid">
                        <div class="spec-detail">
                            <strong>Processor</strong>
                            <div>${product.processor}</div>
                        </div>
                        <div class="spec-detail">
                            <strong>RAM</strong>
                            <div>${product.ram} GB</div>
                        </div>
                        <div class="spec-detail">
                            <strong>Storage</strong>
                            <div>${product.memory} GB</div>
                        </div>
                        <div class="spec-detail">
                            <strong>Screen</strong>
                            <div>${product.screen}/10</div>
                        </div>
                        <div class="spec-detail">
                            <strong>Performance</strong>
                            <div>${product.performance}/10</div>
                        </div>
                        <div class="spec-detail">
                            <strong>Camera</strong>
                            <div>${product.camera}/10</div>
                        </div>
                        <div class="spec-detail">
                            <strong>Connectivity</strong>
                            <div>${product.connectivity}/10</div>
                        </div>
                        <div class="spec-detail">
                            <strong>Battery</strong>
                            <div>${product.battery}/10</div>
                        </div>
                    </div>
                    
                    <div class="product-rating">
                        <span class="stars">${getStars(product.avg_rating)}</span>
                        <span class="rating-count">(${product.review_count || 0} reviews)</span>
                    </div>
                    
                    <button class="btn-primary btn-large btn-block" onclick="addToCart(${product.id})">
                        🛒 Tambah ke Keranjang
                    </button>
                    
                    <a href="${product.link}" target="_blank" class="btn-outline btn-large btn-block" style="display: inline-block; text-align: center; margin-top: 1rem; text-decoration: none;">
                        Lihat di Tokopedia
                    </a>
                </div>
            </div>
        `;

        document.getElementById('productDetail').innerHTML = detailHTML;
        openModal('productModal');
    } catch (error) {
        console.error('Error loading product detail:', error);
    }
}

// Cart Functions
async function addToCart(smartphoneId) {
    if (!authToken) {
        alert('Silakan login terlebih dahulu');
        openModal('loginModal');
        return;
    }

    try {
        const response = await fetch(`${API_URL}/cart`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify({ smartphone_id: smartphoneId, quantity: 1 })
        });

        const data = await response.json();

        if (response.ok) {
            alert('Produk berhasil ditambahkan ke keranjang!');
            updateCartCount();
        } else {
            alert(data.message || 'Gagal menambahkan ke keranjang');
        }
    } catch (error) {
        console.error('Error adding to cart:', error);
        alert('Terjadi kesalahan');
    }
}

async function loadCart() {
    try {
        const response = await fetch(`${API_URL}/cart`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        cart = await response.json();
        displayCart();
        updateCartCount();
    } catch (error) {
        console.error('Error loading cart:', error);
    }
}

function displayCart() {
    const cartItemsDiv = document.getElementById('cartItems');

    if (cart.length === 0) {
        cartItemsDiv.innerHTML = '<p class="loading">Keranjang kosong</p>';
        document.getElementById('cartTotal').textContent = 'Rp 0';
        return;
    }

    const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);

    cartItemsDiv.innerHTML = cart.map(item => `
        <div class="cart-item">
            <img src="http://localhost:5000/images/${item.image_url}" 
                 alt="${item.name}" 
                 class="cart-item-image"
                 onerror="this.src='https://via.placeholder.com/100x100?text=${encodeURIComponent(item.name)}'">
            <div class="cart-item-info">
                <div class="cart-item-name">${item.name}</div>
                <div class="cart-item-price">Rp ${formatPrice(item.price)}</div>
            </div>
            <div class="cart-item-actions">
                <div class="quantity-control">
                    <button class="quantity-btn" onclick="updateCartQuantity(${item.id}, ${item.quantity - 1})">-</button>
                    <span>${item.quantity}</span>
                    <button class="quantity-btn" onclick="updateCartQuantity(${item.id}, ${item.quantity + 1})">+</button>
                </div>
                <button class="btn-secondary" onclick="removeFromCart(${item.id})">Hapus</button>
            </div>
        </div>
    `).join('');

    document.getElementById('cartTotal').textContent = 'Rp ' + formatPrice(total);
}

async function updateCartQuantity(cartId, newQuantity) {
    if (newQuantity < 1) {
        removeFromCart(cartId);
        return;
    }

    try {
        await fetch(`${API_URL}/cart/${cartId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify({ quantity: newQuantity })
        });

        loadCart();
    } catch (error) {
        console.error('Error updating cart:', error);
    }
}

async function removeFromCart(cartId) {
    try {
        await fetch(`${API_URL}/cart/${cartId}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        loadCart();
    } catch (error) {
        console.error('Error removing from cart:', error);
    }
}

async function updateCartCount() {
    if (!authToken) {
        document.getElementById('cartCount').textContent = '0';
        return;
    }

    try {
        const response = await fetch(`${API_URL}/cart`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        const cartItems = await response.json();
        const count = cartItems.reduce((sum, item) => sum + item.quantity, 0);
        document.getElementById('cartCount').textContent = count;
    } catch (error) {
        console.error('Error updating cart count:', error);
    }
}

async function checkout() {
    const address = prompt('Masukkan alamat pengiriman:');

    if (!address) return;

    try {
        const response = await fetch(`${API_URL}/orders`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify({ shipping_address: address })
        });

        const data = await response.json();

        if (response.ok) {
            alert('Pesanan berhasil dibuat!');
            closeModal('cartModal');
            loadCart();
        } else {
            alert(data.message || 'Gagal membuat pesanan');
        }
    } catch (error) {
        console.error('Error creating order:', error);
        alert('Terjadi kesalahan');
    }
}

// Filters
function populateBrandFilter() {
    const brands = [...new Set(allProducts.map(p => p.brand))].sort();
    const select = document.getElementById('brandFilter');

    brands.forEach(brand => {
        const option = document.createElement('option');
        option.value = brand;
        option.textContent = brand;
        select.appendChild(option);
    });
}

function filterProducts() {
    const brand = document.getElementById('brandFilter').value;
    const priceRange = document.getElementById('priceFilter').value;
    const sort = document.getElementById('sortFilter').value;

    let filtered = [...allProducts];

    // Filter by brand
    if (brand) {
        filtered = filtered.filter(p => p.brand === brand);
    }

    // Filter by price
    if (priceRange) {
        const [min, max] = priceRange.split('-').map(Number);
        filtered = filtered.filter(p => p.price >= min && p.price <= max);
    }

    // Sort
    switch (sort) {
        case 'price-low':
            filtered.sort((a, b) => a.price - b.price);
            break;
        case 'price-high':
            filtered.sort((a, b) => b.price - a.price);
            break;
        case 'rating':
            filtered.sort((a, b) => b.avg_rating - a.avg_rating);
            break;
        default:
            // newest - already sorted by created_at DESC from API
            break;
    }

    displayProducts(filtered);
}

// Utility Functions
function formatPrice(price) {
    return new Intl.NumberFormat('id-ID').format(price);
}

function getStars(rating) {
    const fullStars = Math.floor(rating);
    const halfStar = rating % 1 >= 0.5 ? 1 : 0;
    const emptyStars = 5 - fullStars - halfStar;

    return '⭐'.repeat(fullStars) + (halfStar ? '⭐' : '') + '☆'.repeat(emptyStars);
}

function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

function switchToRegister() {
    closeModal('loginModal');
    openModal('registerModal');
}

function switchToLogin() {
    closeModal('registerModal');
    openModal('loginModal');
}

function scrollToProducts() {
    document.getElementById('products').scrollIntoView({ behavior: 'smooth' });
}

function scrollToRecommendations() {
    document.getElementById('recommendations').scrollIntoView({ behavior: 'smooth' });
}

// Close modal when clicking outside
window.onclick = function (event) {
    if (event.target.classList.contains('modal')) {
        event.target.style.display = 'none';
    }
}
