# Changelog

## Changed in v40

* Updated for 11.1.7

## Changed in v39

* Updated for 11.1.5

## Changed in v38

* Updated for 11.1.0
* Bring in systems improvements from [my War Within plugin](https://www.curseforge.com/wow/addons/handynotes-war-within)

## Changed in v37

* Bring in systems improvements from [my War Within plugin](https://www.curseforge.com/wow/addons/handynotes-war-within), notably:
    * Redesign of the settings and menus
    * Filters for rares and treasure so you can choose to show only "notable" ones, which you can configure
    * Color the rare icons to show whether they've got any of those notable things on them -- purple for unknown transmog, blue for more exclusive things
    * Setting for whether to track transmog by shared appearance, or from the specific item (the previous behavior)
    * Support for MapPinEnhanced when setting waypoints

## Changed in v36

* Updated for 11.0.2

## Changed in v35

* Updated for 11.0.0

## Changed in v34

* Updated for 10.2.0
* Handler updates:
  * Routes can appear on the minimap
  * Avoid some possible tooltip errors with other addons
  * Minimap routes should respect display settings
  * New config "only show notable NPCs": enable and rares will only be shown if they've got something for you (achievements or transmogs)

## Changed in v33

* Various achievement mobs have their achievement-criteria added for better completion-checking
* Give the mount-dropping rares a special icon
* Various things should always show on the minimap:
  * Ever-Shifting Mirror portals
  * Voidtalon portals
  * All treasures
* Warleader Tome's route in Nagrand is now shown
* Orumo's note now mentions the apparent workaround to its summoning mechanic

## Changed in v32

* Don't show the Ever-Shifting Mirror portals for people who don't have the toy
* The labels on the portals were inverted
* Fix a coordinate in the note for the Snow Hare's Foot in Frostfire
* Use Blizzard waypoints if TomTom isn't available

## Changed in v31

* Add the portals for the Ever-Shifting Mirror toy
* Fix an error that occurred with the "groups" item in the dropdown menu

## Changed in v30

* Updated for 10.0.2

## Changed in v29

* Updated for 10.0.0

## Changed in v28

* Use LibUIDropDownMenu-4.0 to avoid the taint mess of UIDropDownMenu
* Just use the TOC title for the tooltips
* Show a tooltip on the map icon
* Don't create the point dropdown until it's needed
* Label for criteria=true case should show achievement name
* Some cosmetic items were incorrectly saying they don't drop

## Changed in v27

* Updated for 9.2.7

## Changed in v26

* Updated for 9.2.5, fixing transmog errors
* Systems updates from [HandyNotes: Shadowlands Treasures](https://www.curseforge.com/wow/addons/handynotes-shadowlands-treasures)

## Changed in v25

* Updated for 9.2

## Changed in v24

* Updated for 9.1
* Datamined for missing loot data
* Cross/check in tooltips for knowable loot

## Changed in v23

* Rearranged a lot of data, with various incidental fixups
* Fixed the Voidtalon portals not showing up in zones where you own the treasure map
* Changed the behavior of the treasure-map suppression -- if you set the "show found" option, the treasure-map treasures will now show again
* Fixed Dekorhan's position
* Systems updates from [HandyNotes: Shadowlands Treasures](https://www.curseforge.com/wow/addons/handynotes-shadowlands-treasures):
    * Toggle for the overlay button if you want to disable it
    * Rares which drop collectable loot can be told to count as complete if you've got their drop
    * Rares which are part of an achievement can be told to count as complete if you've got the achievement, regardless of their quest status
    * Changed how tooltips anchor on the map

## Changed in v22

* Added a bunch of missing drops
* Cleaned up some overly long labels

## Changed in v21

* Cleaned up some data, filled out Tanaan Jungle rares better

## Changed in v20

* Pick up fixes and improvements from [HandyNotes: Shadowlands Treasures](https://www.curseforge.com/wow/addons/handynotes-shadowlands-treasures)

## Changed in v19

* Update for 9.0.2

## Changed in v18

* After many years, hide the bugged Sunken Treasure in Shadowmoon Valley

## Changed in v17

* Updated for Shadowlands API changes
* Fixed icons being all over the place while in caves, by update for the new UIMapID system

## Changed in v16

* Updated for Battle for Azeroth API changes
* Fixed TomTom integration

## Changed in v15

* Update for 7.2
* Fix the lunchbox location in Talador
* Add an explanation for acquiring Ahm in Talador
* Fractured Sunstone in Arak has a new questid
* Fix Leorajh's coordinates in Arak
* Add missing Dusty Lockbox in Shadowmoon

## Changed in v14

* Update for 7.1
* Remove the Demon Hunter starting zone
* Finally add the new questid for the formerly-bugged Shadowmoon Valley treasure
* Use named texture atlases, so it's less likely icons will randomly change in future patches

## Changed in v13

* Change how map icons are generated, to use new 7.0 APIs

## Changed in v12

* Updated for 7.0
* Add Voidtalon portals
* Include pre-launch Legion treasures, like Demon Hunter starting zone, temporarily

## Changed in v11

* New option: hide treasures in zones whose map you own
* Added: Ancestral Greataxe
* Include Fen Tao in the Horde side of Ashran as well

## Changed in v10

* The Pepes for I Found Pepe are now listed
* Various missing followers were added

## Changed in v9a

* TOC bumped

## Changed in v9

* Added Tanaan Jungle treasures
* Followers: Goldmane, Dagg, Fen Tao
* For repeatable treasures with a toy, count knowing the toy as "already found"

## Changed in v8

* Followers: Archmage Vargoth
* Fill in missing bits of Frostfire, mostly involving hunting things down inside
  Bladespire Fortress.

## Changed in v7

* The hide-node menu item wasn't clickable if TomTom wasn't installed
* Use the followers API to check whether a follower is already known, so we
  don't have to rely on quest completion
* Follower: Leorajh

## Changed in v6

* Followers: Abu'gar, Artificer Romuul, Tormmok
* ...make faction-specific notes work

## Changed in v5

* Allow hiding of specific nodes
* Fill out Horde garrison
* Allow faction-specific nodes
* Notes on many treasures

## Changed in v4

* Fill out Shadowmoon

## Changed in v3

* If all we know about a node is that there's an NPC, actually display an icon
* Watch for the LOOT_CLOSED event to refresh nodes
* New option: don't show the full item tooltip

## Changed in v2

* Fix adding TomTom waypoints
* Fix lots of small issues with treasure locations and notes

## Changed in v1

* Add: Nagrand, Spires of Arak, Talador, Gorgrond
* Option to not show NPCs

## Changed in v0.1

* Initial release
* Partial Frostfire and Shadowmoon
