sudo apt update && sudo apt upgrade -y
sudo apt install -y nodejs npm nginx
cat < /etc/nginx/sites-available/nextjs <"EOF"
server {
  listen 80;
  server_name YOUR_IP_ADDRESS;
  location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}
EOF
sudo ln -s /etc/nginx/sites-available/nextjs /etc/nginx/sites-enabled/
sudo nginx -t
sudo service nginx restart
git clone your_next_js_app
cd nextjs_app
npm install --legacy-peer-deps
npm audit fix --force
npm run build --no-lint
npm start
