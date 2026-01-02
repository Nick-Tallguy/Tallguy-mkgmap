This is the first version of style, based upon the trike style I've been working on. June 2023 whilst doing part of the Avenue Verte realised that a specialised map just for that route would be the best way to go. Although you can navigate with a gps trace, the Garmin Cycle computer keeps trying to recalculate each time you leave the route - and there have been many times we have had to leave the route because of roadworks, or just because we couldn't see how to make the turning that the route seemed to make - sometimes you are just in the wrong place to see where to go!  Have come to the conclusion that a map with the Avenue Verte (V16) highlighted in a diffferent colour, and perhaps with a different style or emphasis, so that you can see where it is in relation to where you are. 

Trike is 82cm wide.  

Tags for Avenue Verte relation;
bicycle:type = trekking  
name         = Avenue Verte London ↔ Paris, tronçon France - Neuville-sur-Oise <> Paris  
name:en      = Avenue Verte London ↔ Paris, part France Neuville-sur-Oise <> Paris  
network      = ncn  
ref          = V16  
roundrip     = no  
route        = bicycle  
type         = route  
website      = https://www.avenuevertelondonparis.co.uk/


v1 - remove NCN from the start of the route ref (has been showing as NCNV16) & create "route_ref=V16 [0x11 resolution 24]" with XPM format for the route with green border, green & purple alternate in centre. Should stand out quite well I hope.  
   Result - sort of worked, but line is dashed green with no purple on QMapshack. Also, where there is another ncn type route over the same road, it remains red instead of changing to the dashed green.  Route disappears at higher resolutions when in Garmin explore. Doesn't stand out enough.  
v2 - increased width to emphasise, and change purple to red.  Removed relation section about setting to ncn. changed 'resolution to 'level' .
   Result - stands out more, but still not visible when an NCN is present.
v3 - now working for whole of the length of V16, which is the main route, the shorter one, that is more direct. Experimented with colours - Garmin doesn't seem to be able to display some of them, and tried various options. In the end have settled for V16 being the only route in red, with the other ncn type routes sharing the same pink colour as the regional cycle routes. This seems to work quite well and is distinctive on both QMapKarte, and on the Garmin itself. 
v4 - The alternative route in France appears to have the ref V16a - a boim of this version is to get that to display the same as the main route.  Got it right first time! Have set it up so that the relation file tags both V16 & V16a as route_ref=V16  
v5 - Uncluttering - remove banks, hairdressers, etc. etc.. 
v6 - now include GB areas with ref 'AV'. All working as two separate maps - need to work on how to combine them. Liz & Leslie now using old G705's - are my 'beta' testers. Feedback from Leslie that it's showing too many medical points - care homes etc.
v7 - Clinic's removed from medical section on points file. Also removed from polygon file, and removed care homes from there. 
v8 - Another attempt at combining the French & English maps - probably at the splitter stage.  Cracked it - have created a combined geo info file for FR & GB, and used a poly file for europe. now working well.
v9 - clean up the .sh file and then remove more of medical facilities - don't really need dentists. Campsites, hotels and any other accomodation would be good though.  Working well but accomodation not yet updated
v10 - cafe now visible from points file up to resolution 18 (24, 22, 20, 18 then into overview levels.) Works well, but garmin can still decide not to show it if the road is too close.
v11 - Major highways are also a shade of red, which is confusing. Need to be changed urgently. N31 is tagged as highway=trunk (trunk rounda out = 0x0c with colour code FFFFFF(white) & border C5C5C5 (light red). Highway=trunk is 0x02 (not used) & 0x0b (F9B29C(Pink) & border D87559(pink)). Trying #CD9344 which is an amber / yellow colour used for several icons. 
   Problem with building - have tested nick.args - problem still occurs when using a known good version. Problem was with 6000.txt -               XPM file found to have colour hash code copied with two ## instead of #.  
v12 - Cafe resolution is now 20 instead of 18 - should be better than it was.
      Shields removed from non cycle routes
      added line to args file which will allow routing along opposite cycle ways.  
      Main roads are all #CD9344 now - having seen it, would prefer something grey.
v13 - Main roads now #737373, which is the same dark grey as the darker part of the railway track system. - this works well.  
v14 - will apply #737373 to smaller roads - residential and unclass as each of them disappear when viewed on a sunny day. Works well - Liz & Lesley both remarked that things were clearer, and I noticed the same.
v15 - add in road classes so that the garmin routes along cycle routes, preferably Avenue Verte. Need to work out what to do with road speed.  
    4 = Avenue Verte
    4 = Regional Cycle routes
    3 = local cycle routes
    2 = residential & unclassified roads
    1 = other roads, but avoid motorways. 
    0 = motorways
    Cannot use levels lower than 0 (such as -1) as splitter & mkgmap object.  
    Set this & tested it - still not routing along cycleways! Now going to set the road_speed to see if that makes a difference. Took me 2 days to work out what the problem was, but is now routing along the cycleways.
v16 - Added a note to the args file about not using the 'cycle-map' option.  Relations for cycle routes amended. Lines amended slightly - set to prefer cycle routes for navigation - seems to be mainly working. When building displays a warning about a routable way & non routable way - think this refers to my use of red highlighting for Avenue Verte - will look to see if this can be altered to stop the warning, which may improve the routing even more.  0x10 is a customisable route line, currently used by me for Parkruns. 0x10a01 is the one I think is causing problems, used by me for Avenue Verte, but no mention of it being used for routable routes, which may be the problem.  0x11 is only used for highway=cycleway. Sorted an anomoly in the display levels for parkrun - all at level 20 now. Removed Kent from the areas. Put kent back in & reverted to an earlier version of the combined areas, which includes kent as was throwing errors.  Swapped 0x10 & 0x10a01 so that Av Verte is using the routable 0x10, and no longer shows an error when compiling the map. Routing seems to be very good and display looks good. works very well - shows the name of the relation when you are on the route - would be better if it showed 'Ave Verte' followed by the ref, such as 'Ave Verte V16'. 
 v17 - change the name to 'Ave Verte {ref}' 
       Parkruns - just show the start position and not the route or finish.
 v18 - v17 working extremely well. Now adding '--road-name-config' to improve searching of road names in France only at present.  Works well - searching is much quicker now for France - would be good to add this in for Switzerland (CHE). Removed overview levels, and set cafe's, water, and parkruns to only appear at resolution 24
 v19 - Top level to be limited to show London, Paris, whole of Ave Verte, and the coastlines. Possibly add Newhaven & Dieppe to the top level.  This will be level 3 (levels are 0, 1, 2 & 3) or resolution 18 (24, 22, 20, 18).  Have London, Paris, Newhaven & Dieppe. Country boundaries & the sea only - looks good.  
 v20 - Level below top - resolution 20, level 2. Just add in towns, villages & more main water features such as Rivers to the higher level, also have many landuse features appearing.
 v21 - Change the name of the sections, so that display shows 'Avenue Verte' when riding on common sections, and  'Avenue Verte East' if the longer eastern arm is being ridden. Works well as far as I can see.
 v22 - Edge 705's are not showing the route as clearly as I would like - think I need to increase the width. Various alterations to the 6000.txt file - have gone back to a darker green in an attempt to get the route to show up on the Edge530 - shows up as a bold black line at the moment. Also visible on QMapShack, and the other Garmins. Sort of works.  
 v23 - going to try to put text as in 'AV' on the green line of the map.  v23 is a *good* map - fully working, but I think the lines for the AV route do not stand out sufficiently * the stylized AV breaks the route up as well making it more difficult to see.  
 v24 - AV route is now a solid dark green line, 9 pixels wide. Lines - only other with the dark colour was woods, and I've changed that to light green with white tree pattern.
       - Halved the widge of Local cycle network, and changed the colour to the same pink as the regional cycle routes.   
       - removed hospitals icon.
 v25 - changed couple of things to tidy things up - mainly deleting things that have been commented out. Hide cycle parking, and Train / subway stations (platforms), both of which are cluttering screens. Result is good, but village / town names are not showing up.
 v26 - changed the 60000.txt file to make the point names match the points file as far as city, town, village and hamlets are concerned. - Found the problem - QMapShack has an option to turn off the POI text, and I must have done that at some point.  v26 seems to work well though.  
 v27 - 'Options' file now has full description of the levels. Have removed many icons to declutter the map, however although this one works well, the searching does not - need to have the icons for the searching to work. Going to adjust the levels slightly and see if I can get a good compromise.  - 
 v28 - Good map - searching now working. Have kept cycle parking out of the map as that made it too cluttered. Now have 4 levels - need to try it out cycling on the AV verte, but it's looking good so far.  
 v29 - Some parkruns have the start point using the role start_stop - if it's the same place. Need to make sure that these are also found by the search.  
 v30 - currently happily routing cyclists along highway=trunk & highway=trunk link - this changes that so they are avoided. - that worked for Trunk & motorway.  
 v31 - few more 'add bicycle=no' tags to trunk roads. Also slight change to capitals.  
 v32 - about to change more 'add bicycle=no' tags - tracks need something to stop routing along them when not suitable.  Basically tracks need to have a suitable tracktype and smoothness tag before routing will accept them.Now working for track - but routes through areas marked access=private (Bluewater emergency access).  
 v33 - sort out the access tags.
 Spent a couple of days trying various things to make parkruns appear in the search categories, but couldn't get it to work, so have reverted to this version.  The Edge Touring and 810 can each search all POI's and with a text search for 'parkr' they find all the correctly tagged parkruns (beware of accidental capital letters in the relation).
 v34 - working version, just about to create 'inc' files for some sections.

##  ToDo - 
Village & town names.  

Make parkruns searchable - this was at the end of a highway shield section, and makes the name searchable "; addlabel '${name}'}"

