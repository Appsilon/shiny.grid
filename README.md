# shiny.grid
CSS grid implementation for R Shiny

Adds support for creating css grids in shiny components without the need of using css directly.

## Installation

1 - Install the package from github:
```R
devtools::install_github("Appsilon/shiny.grid")
```

2 - Include the library into your project:
```R
# global.R
library(shiny.grid)
```
## Grid Usage
The two main usage cases for `shiny.grid` are grid panels and grid pages:

#### Grid panel
A Grid panel works similar to `div` with the exemption of allowing for a few attributes to be passed by name.

 - `areas`: This is the visual representation of the css grid that you want to define. Its a vector of strings where each element represents a row in the grid, and corresponding names. Its value will be parsed to the css attribute `grid-template-areas`.  

 Lets say for example we want to generate a grid with 2 rows and 2 columns, being the first row a single area and the second row 2 areas:
```R
areas = c(
  "area-1 area-1",
  "area-2 area-3"
)
```

 - `rows`: This defines the size of each row in the grid. By default rows split the available space equally. Translates to `grid-template-rows` in css. The number of elements in the string should be consistent with `areas`. If you defined 3 rows in areas, Make sure your `rows` also contain 3 measures.  

 For example, lets say we have 3 rows but want the first row to use 100px of the space, while the other rows spit the remaining space:
```R
rows = "100px 1fr 1fr"
```

 - `columns`: This defines the size of each column in the grid. By default columns behave the same as columns, splitting the available space equally. Translates to `grid-template-columns` in css. Should be consistent with `areas`. If you defined 3 columns in areas, Make sure your `columns` also contain 3 measures.  

 For example, lets say we have 4 columns but want the first row to use 200px of the space, last one 100px, while the other columns spit the remaining space:
```R
columns = "200px 1fr 1fr 100px"
```

 - `gap`: Gap defines the space between each cell of the grid. This allows you to add some spacing between elements directly in the grid. Expects a single css measure as a string.

 For example, lets say we would like our grid to have a gap of 10px between each cell:
```R
gap = "10px"
```

#### Grid page
Grid page allows you to define a full page consisting of a css grid, wby using the arguments available in `gridPanel`.

NOTE: By default `gridPage` loads all the required bootstrap dependencies. If your project uses a diferent ui framework, you can pass its dependencies via the `dependencies` argument, or by using `gridPanel` directly in your own `Page` function.

```R
# ui.R
ui <- gridPage(
  title = "A grid page",
  areas = c("area-1 area-1", "area-2 area-3"),

  gridPanel(class = "area-1"),
  gridPanel(class = "area-2"),
  gridPanel(class = "area-3")
)
```

#### Media Queries
When dealing with responsive layouts, sometimes you want your grids to have different layouts depending on the screen size. To achieve this with `shiny.grid` you can use `areas`, `columns` and `rows` with a named list instead of their usual value type.

The available list names are based on `shiny.grid::activeMediaRules`, abd by default follow the bootstrap breakpoints:
```R
defaultMediaRules <- list(
  xs = list(max = 575),
  sm = list(min = 576, max = 767),
  md = list(min = 768, max = 991),
  lg = list(min = 992, max = 1199),
  xl = list(min = 1200)
)
```

You can customize the available breakpoints by calling `unregisterMediaRule` and `registerMediaRule` before your UI definition to add or remove breakpoints from the activeMediaRules list. This is specially useful when you want to create specific breakpoints required for your application (For example of you want to follow your own UI framework guidelines).

To use these breakpoints, simple pass multiple `areas`, `columns` and `rows` attributes in a named list using the media query identifier as the name.

A special name `default` can also be used to define values that work for any screen size not included in the media queries provided (Similar to the behavior of passing only one value to each parameter). For example, lets say we would like to add a special case for mobile to the previous area example, where on mobile we get a staked view of each grid area, with a larger gap:

```R
areas = list(
  default = c(
    "area-1 area-1",
    "area-2 area-3"
  ),
  xs = c(
    "area-1",
    "area-2",
    "area-3"
  )
)
```

```R
rows = list(
  default = "100px 1fr",
  xs = "50px 1fr",
)
```

```R
columns = list(
  default = "1fr 2fr",
  xs = "1fr",
)
```

```R
gap = list(
  default = "5px",
  xs = "20px",
)
```

NOTE: `unregisterMediaRule` will most likely not be needed in your average case, but its useful if you want to make sure ui creators do not have access to a specific set of breakpoints. For regular use you can simply not use a breakpoint even if it exists in `shiny.grid::activeMediaRules`.

NOTE: Remember to always set a `default` value unless you plan to define all breakpoints, since this will be the default behavior when the screen size is outside of the defined breakpoints.
