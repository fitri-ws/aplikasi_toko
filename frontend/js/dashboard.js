// API Configuration
const API_URL = 'http://localhost:5000/api';

// State
let currentUser = null;
let authToken = null;
let dashboardStats = null;
let allOrders = [];

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    checkAuth();
    setupEventListeners();
    updateTime();
    setInterval(updateTime, 1000);
});

// Check Authentication
function checkAuth() {
    authToken = localStorage.getItem('authToken');
    const userStr = localStorage.getItem('currentUser');

    if (!authToken || !userStr) {
        window.location.href = 'index.html';
        return;
    }

    currentUser = JSON.parse(userStr);

    if (currentUser.role !== 'admin') {
        alert('Access denied. Admin only.');
        window.location.href = 'index.html';
        return;
    }

    document.getElementById('adminName').textContent = currentUser.full_name;
    loadDashboardData();
}

// Setup Event Listeners
function setupEventListeners() {
    // Sidebar Navigation
    document.querySelectorAll('.sidebar-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const section = e.currentTarget.getAttribute('data-section');
            switchSection(section);
        });
    });

    // Product Form
    document.getElementById('productForm')?.addEventListener('submit', handleProductSubmit);

    // Order Status Filter
    document.getElementById('orderStatusFilter')?.addEventListener('change', filterOrders);
}

// Switch Section
function switchSection(section) {
    // Update sidebar
    document.querySelectorAll('.sidebar-link').forEach(link => {
        link.classList.remove('active');
    });
    document.querySelector(`[data-section="${section}"]`).classList.add('active');

    // Update sections
    document.querySelectorAll('.dashboard-section').forEach(sec => {
        sec.classList.remove('active');
    });
    document.getElementById(`${section}-section`).classList.add('active');

    // Update header
    const titles = {
        overview: 'Dashboard Overview',
        products: 'Product Management',
        orders: 'Order Management',
        users: 'User Management',
        analytics: 'Analytics & Reports'
    };
    document.getElementById('sectionTitle').textContent = titles[section];

    // Load section data
    switch (section) {
        case 'products':
            loadProducts();
            break;
        case 'orders':
            loadOrders();
            break;
        case 'users':
            loadUsers();
            break;
        case 'analytics':
            loadAnalytics();
            break;
    }
}

// Load Dashboard Data
async function loadDashboardData() {
    try {
        const response = await fetch(`${API_URL}/dashboard/stats`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        dashboardStats = await response.json();
        displayDashboardStats();
    } catch (error) {
        console.error('Error loading dashboard:', error);
    }
}

// Display Dashboard Stats
function displayDashboardStats() {
    const stats = dashboardStats;

    // Update stat cards
    document.getElementById('totalUsers').textContent = stats.totalUsers;
    document.getElementById('totalOrders').textContent = stats.totalOrders;
    document.getElementById('totalRevenue').textContent = 'Rp ' + formatPrice(stats.totalRevenue);
    document.getElementById('totalProducts').textContent = stats.totalProducts;

    // Display brand chart
    displayBrandChart(stats.salesByBrand);

    // Display status chart
    displayStatusChart(stats.ordersByStatus);

    // Display recent orders
    displayRecentOrders(stats.recentOrders);

    // Display top products
    displayTopProducts(stats.topProducts);
}

// Display Brand Chart
function displayBrandChart(data) {
    const container = document.getElementById('brandChart');

    if (!data || data.length === 0) {
        container.innerHTML = '<p class="loading">No data available</p>';
        return;
    }

    const maxSales = Math.max(...data.map(d => d.sales_count));

    container.innerHTML = `
        <div class="bar-chart">
            ${data.map(item => `
                <div class="bar-item">
                    <div class="bar-label">${item.brand}</div>
                    <div class="bar-container">
                        <div class="bar-fill" style="width: ${(item.sales_count / maxSales) * 100}%">
                            ${item.sales_count}
                        </div>
                    </div>
                </div>
            `).join('')}
        </div>
    `;
}

// Display Status Chart
function displayStatusChart(data) {
    const container = document.getElementById('statusChart');

    if (!data || data.length === 0) {
        container.innerHTML = '<p class="loading">No data available</p>';
        return;
    }

    const maxCount = Math.max(...data.map(d => d.count));

    const statusColors = {
        pending: '#fbbf24',
        processing: '#3b82f6',
        shipped: '#8b5cf6',
        delivered: '#10b981',
        cancelled: '#ef4444'
    };

    container.innerHTML = `
        <div class="bar-chart">
            ${data.map(item => `
                <div class="bar-item">
                    <div class="bar-label">${capitalizeFirst(item.status)}</div>
                    <div class="bar-container">
                        <div class="bar-fill" style="width: ${(item.count / maxCount) * 100}%; background: ${statusColors[item.status]}">
                            ${item.count}
                        </div>
                    </div>
                </div>
            `).join('')}
        </div>
    `;
}

// Display Recent Orders
function displayRecentOrders(orders) {
    const container = document.getElementById('recentOrders');

    if (!orders || orders.length === 0) {
        container.innerHTML = '<p class="loading">No recent orders</p>';
        return;
    }

    container.innerHTML = `
        <table class="data-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Total</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                ${orders.slice(0, 5).map(order => `
                    <tr>
                        <td>#${order.id}</td>
                        <td>${order.full_name}</td>
                        <td>Rp ${formatPrice(order.total_amount)}</td>
                        <td><span class="status-badge status-${order.status}">${capitalizeFirst(order.status)}</span></td>
                    </tr>
                `).join('')}
            </tbody>
        </table>
    `;
}

// Display Top Products
function displayTopProducts(products) {
    const container = document.getElementById('topProducts');

    if (!products || products.length === 0) {
        container.innerHTML = '<p class="loading">No data available</p>';
        return;
    }

    container.innerHTML = `
        <table class="data-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Brand</th>
                    <th>Sold</th>
                </tr>
            </thead>
            <tbody>
                ${products.map(product => `
                    <tr>
                        <td>${product.name}</td>
                        <td>${product.brand}</td>
                        <td><strong>${product.total_sold}</strong></td>
                    </tr>
                `).join('')}
            </tbody>
        </table>
    `;
}

// Load Products
async function loadProducts() {
    try {
        const response = await fetch(`${API_URL}/smartphones`);
        const products = await response.json();

        displayProductsTable(products);
    } catch (error) {
        console.error('Error loading products:', error);
    }
}

// Display Products Table
function displayProductsTable(products) {
    const tbody = document.getElementById('productsTableBody');

    tbody.innerHTML = products.map(product => `
        <tr>
            <td>${product.id}</td>
            <td>
                <img src="http://localhost:5000/images/${product.image_url}" 
                     alt="${product.name}" 
                     class="product-thumb"
                     onerror="this.src='https://via.placeholder.com/50x50'">
            </td>
            <td>${product.name}</td>
            <td>${product.brand}</td>
            <td>Rp ${formatPrice(product.price)}</td>
            <td>${product.stock}</td>
            <td>${product.avg_rating ? product.avg_rating.toFixed(1) : '0.0'} ⭐</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-small btn-edit" onclick="editProduct(${product.id})">Edit</button>
                    <button class="btn-small btn-delete" onclick="deleteProduct(${product.id})">Delete</button>
                </div>
            </td>
        </tr>
    `).join('');
}

// Open Add Product Modal
function openAddProductModal() {
    document.getElementById('productModalTitle').textContent = 'Add New Product';
    document.getElementById('productForm').reset();
    document.getElementById('productId').value = '';
    openModal('productModal');
}

// Edit Product
async function editProduct(id) {
    try {
        const response = await fetch(`${API_URL}/smartphones/${id}`);
        const product = await response.json();

        document.getElementById('productModalTitle').textContent = 'Edit Product';
        document.getElementById('productId').value = product.id;
        document.getElementById('productName').value = product.name;
        document.getElementById('productBrand').value = product.brand;
        document.getElementById('productPrice').value = product.price;
        document.getElementById('productStock').value = product.stock;
        document.getElementById('productProcessor').value = product.processor || '';
        document.getElementById('productRam').value = product.ram || '';
        document.getElementById('productMemory').value = product.memory || '';
        document.getElementById('productImage').value = product.image_url || '';
        document.getElementById('productScreen').value = product.screen || '';
        document.getElementById('productPerformance').value = product.performance || '';
        document.getElementById('productCamera').value = product.camera || '';
        document.getElementById('productConnectivity').value = product.connectivity || '';
        document.getElementById('productBattery').value = product.battery || '';
        document.getElementById('productLink').value = product.link || '';

        openModal('productModal');
    } catch (error) {
        console.error('Error loading product:', error);
    }
}

// Handle Product Submit
async function handleProductSubmit(e) {
    e.preventDefault();

    const productId = document.getElementById('productId').value;
    const productData = {
        name: document.getElementById('productName').value,
        brand: document.getElementById('productBrand').value,
        price: parseFloat(document.getElementById('productPrice').value),
        stock: parseInt(document.getElementById('productStock').value),
        processor: document.getElementById('productProcessor').value,
        ram: parseInt(document.getElementById('productRam').value) || 0,
        memory: parseInt(document.getElementById('productMemory').value) || 0,
        image_url: document.getElementById('productImage').value,
        screen: parseFloat(document.getElementById('productScreen').value) || 0,
        performance: parseFloat(document.getElementById('productPerformance').value) || 0,
        camera: parseFloat(document.getElementById('productCamera').value) || 0,
        connectivity: parseFloat(document.getElementById('productConnectivity').value) || 0,
        battery: parseFloat(document.getElementById('productBattery').value) || 0,
        link: document.getElementById('productLink').value
    };

    try {
        const url = productId ? `${API_URL}/smartphones/${productId}` : `${API_URL}/smartphones`;
        const method = productId ? 'PUT' : 'POST';

        const response = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify(productData)
        });

        const data = await response.json();

        if (response.ok) {
            alert(productId ? 'Product updated successfully!' : 'Product added successfully!');
            closeModal('productModal');
            loadProducts();
        } else {
            alert(data.message || 'Failed to save product');
        }
    } catch (error) {
        console.error('Error saving product:', error);
        alert('An error occurred');
    }
}

// Delete Product
async function deleteProduct(id) {
    if (!confirm('Are you sure you want to delete this product?')) return;

    try {
        const response = await fetch(`${API_URL}/smartphones/${id}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        if (response.ok) {
            alert('Product deleted successfully!');
            loadProducts();
            loadDashboardData();
        } else {
            alert('Failed to delete product');
        }
    } catch (error) {
        console.error('Error deleting product:', error);
    }
}

// Load Orders
async function loadOrders() {
    try {
        const response = await fetch(`${API_URL}/orders/all`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        allOrders = await response.json();
        displayOrdersTable(allOrders);
    } catch (error) {
        console.error('Error loading orders:', error);
    }
}

// Display Orders Table
function displayOrdersTable(orders) {
    const tbody = document.getElementById('ordersTableBody');

    tbody.innerHTML = orders.map(order => `
        <tr>
            <td>#${order.id}</td>
            <td>${order.full_name}</td>
            <td>Rp ${formatPrice(order.total_amount)}</td>
            <td>${order.item_count} items</td>
            <td>
                <select class="status-badge status-${order.status}" 
                        onchange="updateOrderStatus(${order.id}, this.value)"
                        style="border: none; font-weight: 600; cursor: pointer;">
                    <option value="pending" ${order.status === 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="processing" ${order.status === 'processing' ? 'selected' : ''}>Processing</option>
                    <option value="shipped" ${order.status === 'shipped' ? 'selected' : ''}>Shipped</option>
                    <option value="delivered" ${order.status === 'delivered' ? 'selected' : ''}>Delivered</option>
                    <option value="cancelled" ${order.status === 'cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>
            </td>
            <td>${new Date(order.created_at).toLocaleDateString('id-ID')}</td>
            <td>
                <button class="btn-small btn-view" onclick="viewOrderDetail(${order.id})">View</button>
            </td>
        </tr>
    `).join('');
}

// Filter Orders
function filterOrders() {
    const status = document.getElementById('orderStatusFilter').value;

    if (!status) {
        displayOrdersTable(allOrders);
    } else {
        const filtered = allOrders.filter(order => order.status === status);
        displayOrdersTable(filtered);
    }
}

// Update Order Status
async function updateOrderStatus(orderId, newStatus) {
    try {
        const response = await fetch(`${API_URL}/orders/${orderId}/status`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${authToken}`
            },
            body: JSON.stringify({ status: newStatus })
        });

        if (response.ok) {
            alert('Order status updated!');
            loadOrders();
            loadDashboardData();
        } else {
            alert('Failed to update status');
        }
    } catch (error) {
        console.error('Error updating order status:', error);
    }
}

// View Order Detail
async function viewOrderDetail(orderId) {
    try {
        const response = await fetch(`${API_URL}/orders/${orderId}`, {
            headers: {
                'Authorization': `Bearer ${authToken}`
            }
        });

        const order = await response.json();

        const detailHTML = `
            <div class="order-detail">
                <p><strong>Order ID:</strong> #${order.id}</p>
                <p><strong>Total:</strong> Rp ${formatPrice(order.total_amount)}</p>
                <p><strong>Status:</strong> <span class="status-badge status-${order.status}">${capitalizeFirst(order.status)}</span></p>
                <p><strong>Shipping Address:</strong> ${order.shipping_address}</p>
                <p><strong>Date:</strong> ${new Date(order.created_at).toLocaleString('id-ID')}</p>
                
                <h3 style="margin-top: 2rem; margin-bottom: 1rem;">Order Items</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${order.items.map(item => `
                            <tr>
                                <td>${item.name}</td>
                                <td>${item.quantity}</td>
                                <td>Rp ${formatPrice(item.price)}</td>
                                <td>Rp ${formatPrice(item.price * item.quantity)}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            </div>
        `;

        document.getElementById('orderDetail').innerHTML = detailHTML;
        openModal('orderModal');
    } catch (error) {
        console.error('Error loading order detail:', error);
    }
}

// Load Users
async function loadUsers() {
    try {
        // Since we don't have a users endpoint, we'll show a placeholder
        const tbody = document.getElementById('usersTableBody');
        tbody.innerHTML = '<tr><td colspan="6" class="loading">User management coming soon</td></tr>';
    } catch (error) {
        console.error('Error loading users:', error);
    }
}

// Load Analytics
function loadAnalytics() {
    if (!dashboardStats) return;

    // Calculate metrics
    const avgOrderValue = dashboardStats.totalOrders > 0
        ? dashboardStats.totalRevenue / dashboardStats.totalOrders
        : 0;

    document.getElementById('avgOrderValue').textContent = 'Rp ' + formatPrice(avgOrderValue);
    document.getElementById('conversionRate').textContent = '12.5%'; // Placeholder

    const totalItemsSold = dashboardStats.topProducts?.reduce((sum, p) => sum + parseInt(p.total_sold || 0), 0) || 0;
    document.getElementById('totalItemsSold').textContent = totalItemsSold;

    // Display inventory status
    displayInventoryStatus();
}

// Display Inventory Status
async function displayInventoryStatus() {
    try {
        const response = await fetch(`${API_URL}/smartphones`);
        const products = await response.json();

        const lowStock = products.filter(p => p.stock < 10);
        const container = document.getElementById('inventoryStatus');

        if (lowStock.length === 0) {
            container.innerHTML = '<p class="loading">All products have sufficient stock</p>';
            return;
        }

        container.innerHTML = `
            <div class="inventory-list">
                ${lowStock.map(product => `
                    <div class="inventory-item">
                        <span>${product.name}</span>
                        <span class="${product.stock < 5 ? 'stock-low' : 'stock-medium'}">
                            ${product.stock} units
                        </span>
                    </div>
                `).join('')}
            </div>
        `;
    } catch (error) {
        console.error('Error loading inventory:', error);
    }
}

// Utility Functions
function formatPrice(price) {
    return new Intl.NumberFormat('id-ID').format(price);
}

function capitalizeFirst(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

function updateTime() {
    const now = new Date();
    const timeStr = now.toLocaleString('id-ID', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
    document.getElementById('currentTime').textContent = timeStr;
}

function refreshData() {
    loadDashboardData();
    const activeSection = document.querySelector('.sidebar-link.active').getAttribute('data-section');
    switchSection(activeSection);
}

function logout() {
    localStorage.removeItem('authToken');
    localStorage.removeItem('currentUser');
    window.location.href = 'index.html';
}

// Close modal when clicking outside
window.onclick = function (event) {
    if (event.target.classList.contains('modal')) {
        event.target.style.display = 'none';
    }
}
