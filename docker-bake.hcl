variable "VERSION" {
  # renovate: datasource=repology depName=alpine_3_24/proftpd
  default = "1.3.9b-r1"
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
