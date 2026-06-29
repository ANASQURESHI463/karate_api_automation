function fn() {
    karate.log('Loading Karate Config');

    var config = {
        baseUrl: 'https://automationintesting.online/api',
        endpoint: {
            auth: '/auth/login',
            branding: '/branding',
            rooms: '/room',
            booking: '/booking'
        }
    };

    return config;
}