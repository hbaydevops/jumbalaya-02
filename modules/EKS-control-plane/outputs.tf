output "thumbprint_hash" {
  value = data.tls_certificate.example.certificates.0.sha1_fingerprint
}