nmcli connection add 
  type wifi con-name "eduroam" ifname wlp2s0 ssid "eduroam" -- \
  wifi-sec.key-mgmt wpa-eap 802-1x.eap tls 802-1x.identity "<identity>" \
  802-1x.ca-cert ~/.eduroam/easyroam_root_ca.pem \
  802-1x.private-key-password "<PASSWORD>" 802-1x.private-key ~/.eduroam/easyroam_client_key.pem \
  802-1x.client-cert ~/.eduroam/easyroam_client_cert.pem
