#' @import RProtoBuf
.onLoad <- function(libname, pkgname) {
  proto_dir <- system.file("proto", package = "sg.data")
  proto_path <- "/usr/local/opt/protobuf/include"
  RProtoBuf::readProtoFiles2(dir = proto_dir, protoPath = proto_path)
}

.onUnload <- function(libname, pkgname) {
  RProtoBuf::resetDescriptorPool()
}
