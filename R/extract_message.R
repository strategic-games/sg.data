#' Returns a RProtoBuf message as list structure
#'
#' [RProtoBuf::as.list.Message()] does not coerce the message fields. [extract_message()] inspects the whole tree of message fields recursively and returns the message as tree structure of lists and atomic leafs.
#'
#' @param x A RProtoBuf Message, list or atomic
#' @return A list if x is a Message or recursive, or an atomic if x is atomic
#' @importFrom purrr map
#' @importFrom lubridate as_datetime
#' @export
extract_message <- function(x) {
  if (is.atomic(x)) {
    return(x)
  }
  if (is.recursive(x)) {
    return(map(x, extract_message))
  }
  if (class(x) == "Message") {
    if (name(descriptor(x)) == "Timestamp") {
      as_datetime(x$seconds)
    } else {
      map(as.list(x), extract_message)
    }
  }
}
