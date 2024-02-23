# Tallguy-mkgmap

At present (February 2024), the main content here is a working set of files to create a Garmin compatible map for a recumbent trike rider.

## Trike

### The Garmin compatible map for a recumbent trike rider


![rcn-steps](/assets/rcn_steps.png "Screenshot of steps highlighted on rcn in Maidstone"){: align="centre" width="95%"}

The aim is to produce a map which you can use in a garmin cycle computer with your trike, able to route you, and which you can search for features. But perhaps more importantly, you can view the map on something like [QMapShack](https://github.com/Maproom/qmapshack/wiki/DocMain), [Garmin Basecamp](https://www.garmin.com/en-GB/software/basecamp/) or just on your actual cycle computer, and see if there will be some kind of 'hiccup' which will cause you problems when you find it. Personally I've found problems on 'The Avenue Verte' where I found a bridge with hundreds of steps that defeated me, NCN1 in the UK with cycle barriers that blocked me, and a railway bridge in Scotland that I had to take a 10 mile diversion round the roads to avoid when riding my recumbent trike.  

Using [MKGMAP](https://www.mkgmap.org.uk/) it is possible to create a map that only shows barriers which will affect a vehicle (in this case a recumbent trike) of a certain width. My trikes are 82cm in width, so that's the width I've chosen whilst creating this map. For instance, and bollards which have a gap between them of 82cm or less are shown on this map, and their actual available width of 'gap' is shown. If the bollards don't have their width of opening (maxwidth:physical) marked on [OpenStreetMap](https://www.openstreetmap.org) then bollards will appear on the map as 'Bollard Gap?' - it's easy to update OpenStreetMap so the actual gap is shown.  

Need to create;

+  bash script
+  Lua file to preprocess the osm data 
+  typ files

Out of date info below this line
--------------------------------


Trike  
-----

As a recumbent trike rider, and a frequent traveller on the GB canal system, I would like to have maps on my navigation devices that assist. I have **NCN 1** fairly near me, and fond memories of riding it when I rode a 2 wheel bike and was a Sustrans Ranger, but parts of it are a 'show stopper' for me on my trike as they have narrow gaps between bollards which require me to get off and try to lift the trike over a chest high gate - not easy or fun for me if on my own - I'm thinking that some kind of warning on the map so I can chose whether to try to negotiate the barrier, or not go that way at all, would be helpful.  


Wheelchair & 'electric buggy'  
----------

There are similarities between my needs on a recumbent trike, and the needs of a wheelchair user - width, and smoothness of terrain are important considerations. Maybe something that works for a trike can be slightly adapted for a wheelchair user. I have friends who have mentioned how frustrating it is to go somewhere with a walk planned, only to find they can't get the wheelchair out of the car park!  


Home Computers  
--------------

Sometimes I have no internet access when planning, and I've found that [QMapShack](https://github.com/Maproom/qmapshack/wiki/DocMain) is very good. It works with Garmin Maps, and can be entirely offline. It runs well on my Ubuntu laptop, and also on my frequently used RPI4 running Raspbian. I often research my rides, or OSM survey rides, before I go. My wife and I have a long term project of riding the complete [North Sea Cycle Ride](https://en.eurovelo.com/ev12/united-kingdom) and an offline programme I can use in my caravan without internet access comes in very handy. 


Canal or Waterways
------------------

Holidaying on a canal boat in the UK is another passion. My mobile phone with [OSMAND plus](https://osmand.net/) works extremely well, but the phone battery does not last for long when navigating. Using a handheld or cycle GPS works well, but I need a dedicated map which shows **bridge_ref** and **Lock names** other relevant canal features - it will never replace the printed Canal Guides, but something that shows me where I am so I know which page to look for in the guide would be handy.  


Guides and Resources
--------------------

The following Guides and Resources may help in producing the maps;  

[OpenStreetMap Wiki for MKGMAP](https://wiki.openstreetmap.org/wiki/Mkgmap)  

[OSM wiki entry concerning compilint a typ file](https://wiki.openstreetmap.org/wiki/Mkgmap/help/typ_compile)  

[MKGMAP Website](https://www.mkgmap.org.uk/) Documentation on the site, downloads of mkgmap and splitter, links for downloads of sea data, bounds, and city data.

[Downloads of OSM data from Geofabrik](https://download.geofabrik.de/) Also boundaries.  

[Garmin POI types](https://wiki.openstreetmap.org/wiki/OSM_Map_On_Garmin/POI_Types)


GPS's
-----

Cycling = Garmin Edge 705

Handheld = Garmin etrex 30
