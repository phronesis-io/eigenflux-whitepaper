#!/bin/bash
PORT=8080
IP=$(ipconfig getifaddr en0 2>/dev/null || echo "localhost")
echo "白皮书已启动：http://$IP:$PORT"
echo "按 Ctrl+C 停止"
cd "$(dirname "$0")/.." && python3 -m http.server $PORT
