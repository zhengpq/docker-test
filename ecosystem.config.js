console.log('pakizheng process.env.APP_PORT', process.env.APP_PORT);
module.exports = {
    apps: [
        {
            name: 'docker-test',
            script: './src/index.js',
            env: {
                NODE_ENV: 'development',
            },
            env_production: {
                NODE_ENV: 'production',
                PORT: process.env.APP_PORT,
                node_args: '--inspect=0.0.0.0:9229',
            },
        },
    ],
};
