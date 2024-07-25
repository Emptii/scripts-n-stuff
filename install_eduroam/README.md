## Install eduroam

### Summary

The official instructions listed [here](https://doku.tid.dfn.de/de:eduroam:easyroam#installation_der_easyroam_profile_auf_linux_geraeten) did not work for me.

Here is how I installed the eduroam connection via nmcli (NetworkManager-cli).

### Instructions

1. Connect to the internet via e.g. a hotspot
2. To make following these instructions easier, navigate to `~/.eduroam`.
3. login to https://www.eduroam.de and get yourself a p12 file. Rename it to `my_easyroam_cert.p12`.
4. run the following commands to create your client certificate.

```bash
openssl pkcs12 -in my_easyroam_cert.p12 -legacy -nokeys | openssl x509 > easyroam_client_cert.pem
```

4. Extract your <identity>. The output will be similar to this : `subject=CN=<identity>, C=DE, ST=Berlin, L=Berlin, O=DFN-Verein`}

```bash
openssl x509 -noout -subject -in easyroam_client_cert.pem -legacy | sed 's/.*CN = \(.*\), C.*/\1/'
```

5. create your client's private key

```bash
openssl pkcs12 -legacy -in my_easyroam_cert.p12 -nodes -nocerts -out temp_key.pem
openssl rsa -aes256 -in temp_key.pem -out easyroam_client_key.pem
rm temp_key.pem
```

6. create the RootCA certificate

```bash
openssl pkcs12 -in my_easyroam_cert.p12 -legacy -cacerts -nokeys > easyroam_root_ca.pem
```

7. insert your <identity> and <password> (if you used one in the steps above) into the `add_eduroam_connection.sh`.

### Tips

Make sure the device id is correct for your device. For example I didn't get my connection up, since I fist used `wlp3s0` instead of the one I actually had `wlp2s0`.
