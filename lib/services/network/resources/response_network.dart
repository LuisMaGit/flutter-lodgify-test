class ResponseNetwork<DTO> {
  final DTO? data;
  final bool error;
  final String message;
  ResponseNetwork({
    this.data,
    this.error = false,
    this.message = "",
  });
}