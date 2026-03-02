import { application } from "controllers/application"

import SidebarController from "controllers/sidebar_controller"
import DarkModeController from "controllers/dark_mode_controller"
import AnimatedCounterController from "controllers/animated_counter_controller"
import ChartController from "controllers/chart_controller"
import ToastController from "controllers/toast_controller"
import SearchController from "controllers/search_controller"
import DropdownController from "controllers/dropdown_controller"
import TabsController from "controllers/tabs_controller"

application.register("sidebar", SidebarController)
application.register("dark-mode", DarkModeController)
application.register("animated-counter", AnimatedCounterController)
application.register("chart", ChartController)
application.register("toast", ToastController)
application.register("search", SearchController)
application.register("dropdown", DropdownController)
application.register("tabs", TabsController)
