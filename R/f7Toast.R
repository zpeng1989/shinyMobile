#' Create a Framework7 toast
#'
#' @param text Toast content.
#' @param position Toast position \code{c("bottom", "top", "center")}.
#' @param closeButton Whether to close the toast with a button.
#' TRUE by default.
#' @param closeButtonText Close button text.
#' @param closeButtonColor Close button color.
#' @param closeTimeout Time before toast closes.
#' @param icon Optional. Expect \link{f7Icon}. Warning:
#' Adding icon will hide the close button.
#' @param session Shiny session.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "f7Toast"),
#'       f7Button(inputId = "toast", label = "Open Toast")
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observeEvent(input$toast, {
#'       f7Toast(
#'         session,
#'         position = "top",
#'         text = "I am a toast. Eat me!"
#'       )
#'     })
#'   }
#'  )
#' }
f7Toast <- function(session, text, position = c("bottom", "top", "center"),
                    closeButton = TRUE, closeButtonText = "close",
                    closeButtonColor = "red", closeTimeout = 3000, icon = NULL) {

  icon <- if(!is.null(icon)) as.character(icon)

  position <- match.arg(position)

  message <- dropNulls(
    list(
      text = text,
      position = position,
      closeTimeout = closeTimeout,
      icon = icon,
      closeButton = tolower(closeButton),
      closeButtonText = closeButtonText,
      closeButtonColor = closeButtonColor
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = "toast", message = message)
}
