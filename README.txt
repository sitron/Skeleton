This project is an attempt to build a basic skeleton for my RobotLegs based sites.

Features:
- xml sitemap (definition of site pages)
- site "flow" based on event mechanism
- basic menu auto build out of sitemap
- context menu
- exclude page mechanism to update url for intra-page (version 1, very fragile...)
- showChild page logic to redirect a page to one of its children (show first pic at start in gallery for ex.)
- page xml is parsed to specific VOs to your needs

Todo:
- should PageMediator call a "start()" function in its view component? (so that a page doesn't have to add a onAddedToStage listener)
- tree menu
- text and style utils (somaText for ex.)
- use RL loading utility rather than Bulkloader
- project preloader
- ...


Use it as you wish!
created by laurent prodon (sitronnier.com)