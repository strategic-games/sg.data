#' Returns a RProtoBuf message as list structure
#'
#' [RProtoBuf::as.list.Message()] does not coerce the message fields. [extract_message()] inspects the whole tree of message fields recursively and returns the message as tree structure of lists and atomic leafs.
#'
#' @param x A RProtoBuf Message, list or atomic
#' @return A list if x is a Message or recursive, or an atomic if x is atomic
#' @export
extract_message <- function(x) {
  if (is.character(x)) {
    return(enc2utf8(x))
  }
  if (is.atomic(x)) {
    return(x)
  }
  if (is.recursive(x) && length(x) == 0) {
    return(NA)
  }
  if (is.recursive(x)) {
    return(lapply(x, FUN = extract_message))
  }
  if (class(x) == "Message") {
    if (name(descriptor(x)) == "Timestamp") {
      as.POSIXct(x[["seconds"]], tz = "UTC", origin = "1970-01-01")
    } else {
      lapply(as.list(x), FUN = extract_message)
    }
  }
}
