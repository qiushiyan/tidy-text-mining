theme_bar <- function(base_size = 11,
                      strip_text_size = 12,
                      strip_text_margin = 5,
                      subtitle_size = 13,
                      subtitle_margin = 10,
                      plot_title_size = 16,
                      plot_title_margin = 10,
                      ...) {
  ret <- ggplot2::theme_minimal(base_size = base_size, ...)
  ret$strip.text <- ggplot2::element_text(
    hjust = 0, size = strip_text_size,
    margin = ggplot2::margin(b = strip_text_margin)
  )
  ret$plot.subtitle <- ggplot2::element_text(
    hjust = 0, size = subtitle_size,
    margin = ggplot2::margin(b = subtitle_margin)
  )
  ret$plot.title <- ggplot2::element_text(
    hjust = 0, size = plot_title_size,
    margin = ggplot2::margin(b = plot_title_margin)
  )
  ret
}



facet_bar <- function(df, y, x, by, alpha = 0.8, nrow = 2, ncol = 2, scales = "free") {
  mapping <- aes(y = reorder_within({{ y }}, {{ x }}, {{ by }}), 
                 x = {{ x }}, 
                 fill = {{ by }})
  
  facet <- facet_wrap(vars({{ by }}), 
                      nrow = nrow, 
                      ncol = ncol,
                      scales = scales) 
  
  ggplot(df, mapping = mapping) + 
    geom_col(show.legend = FALSE, alpha = alpha) + 
    scale_y_reordered() +
    scale_x_continuous(expand = c(0, 0)) + 
    facet + 
    ylab("") + 
    theme_bar()
} 
