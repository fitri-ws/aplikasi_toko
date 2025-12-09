const bcrypt = require('bcryptjs');

// Generate proper bcrypt hash for admin password
const password = 'admin123';

bcrypt.hash(password, 10, (err, hash) => {
    if (err) {
        console.error('Error:', err);
        return;
    }

    console.log('Password:', password);
    console.log('Bcrypt Hash:', hash);
    console.log('\nCopy this hash to database.sql for admin user password field');
});
