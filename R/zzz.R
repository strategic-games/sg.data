.onLoad <- function(libname, pkgname) {
  proto_dir <- system.file("proto", package = "sg.data")
  RProtoBuf::readProtoFiles2(protoPath = proto_dir)
}

.onUnload <- function(libname, pkgname) {
  RProtoBuf::resetDescriptorPool()
}
