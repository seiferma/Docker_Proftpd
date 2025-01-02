variable "VERSION" {
  default = "1.3"
}

group "default" {
  targets = ["default"]
}

target "default" {
  platforms = ["linux/amd64", "linux/arm64"]
  tags = ["quay.io/seiferma/proftpd:latest", "quay.io/seiferma/proftpd:${VERSION}"]
  args = {
    VERSION = "${VERSION}"
  }
}
