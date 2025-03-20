# Tallguy-mkgmap 

**All mapping data is derived from [OpenStreetMap](https://www.openstreetmap.org/copyright), including the downloadable maps. Many thanks to OpenStreetMap contributors for their skill & dedication.**


## Canal Map

Not something to navigate by, but something that may help you! Treat as a bit of fun.

![canal-2](/assets/canal-2.jpg "Screenshot of canal with locks and a bridge")

Useful if you want to see where you are in relation to locks, bridges and other features such as turning points (winding holes). It is **not** routable for boats, but is useful, and can be fun to look at - I find it useful when trying to work out exactly where winding holes and other features are ahead of me. I keep an old Garmin edge cycle computer at the back of the boat with me.   

![canal-1](/assets/canal-1.jpg "Screenshot of canal with locks and a bridge")

![canal-3](/assets/canal-3.jpg "Screenshot of canal with locks and a bridge")

The levels on the map are currently;
levels = 0:24, 1:22, 2:20, 3:18

GPS Scale|level|resolution|Comment|
|:--:|:--:|:--:|--|
|20ft|0|24|
|30ft|0|24|
|50ft|0|24|
|80ft|0|24|
|120ft|0|24|
|200ft|0|24|
|300ft|0|24|
|500ft|0|24|
|800ft|1|22|This is most used by me
|0.2m|1|22|This is most used by me
|0.3m|1|22|This is most used by me
|0.5m|2|20|This is most used by me
|0.8m|2|20|This is most used by me
|1.2m|2|20|This is most used by me
|2m|3|18|
|3m|3|18|
|5m|3|18|
|8m|3|18|
|12m|3|18|
|20m|3|18|
|30m|3|18|
|50m|3|18|



## Trike Map - Experimental at this stage 

Produces a cycle map aimed at a recumbent trike rider with a trike 0.82 metres wide. - Any barriers which have an available width of less than 85cm, and are on a route that could be cycled are shown with a red B in a circle. The map is routable, but will show barriers with a red circled B if you will not fit through (caveat, if the opening width has not been updated on OpenStreetMap (OSM), then the map displays the red B in a circle as a warning that you may have a problem there (Perhaps you could update OSM so that the next trike rider has a better map). 

### The Garmin compatible map for a recumbent trike rider


![rcn-steps](/assets/rcn_steps.png "Screenshot of steps highlighted on rcn in Maidstone")

The aim is to produce a map which you can use in a garmin cycle computer with your trike, able to route you, and which you can search for features. But perhaps more importantly, you can view the map on something like [QMapShack](https://github.com/Maproom/qmapshack/wiki/DocMain), [Garmin Basecamp](https://www.garmin.com/en-GB/software/basecamp/) or just on your actual cycle computer, and see if there will be some kind of 'hiccup' which will cause you problems when you find it. Personally I've found problems on 'The Avenue Verte' where I found a bridge with hundreds of steps that defeated me, NCN1 in the UK with cycle barriers that blocked me, and a railway bridge in Scotland that I had to take a 10 mile diversion round the roads to avoid when riding my recumbent trike.  

Using [MKGMAP](https://www.mkgmap.org.uk/) it is possible to create a map that only shows barriers which will affect a vehicle (in this case a recumbent trike) of a certain width. One of my trikes is 82cm in width, so that's the width I've chosen whilst creating this map. For instance, any bollards which have a gap between them of 85cm or less are shown on this map, and their actual available width of 'gap' is shown. If the bollards don't have their width of opening (maxwidth:physical) marked on [OpenStreetMap](https://www.openstreetmap.org) then bollards will appear on the map as **'Bollard Gap?'** - it's easy to update OpenStreetMap so the actual gap is shown.  

This map has been created using OpenStreetMap data, and a number of other programmes to manipulate the data.

### Background

As a recumbent trike rider, I would like to have maps on my navigation devices that assist me. I have **NCN 1** fairly near me, and fond memories of riding it when I rode a 2 wheel bike and was a Sustrans Ranger, but parts of it are a 'show stopper' for me on my trike as they have narrow gaps between bollards which require me to get off and try to lift the trike over a chest high gate - not easy or fun for me if on my own - I'm thinking that some kind of warning on the map so I can choose whether to try to negotiate the barrier, or not go that way at all, would be helpful.  


### GPS's

Cycling = Garmin Edge 705, 605 & Edge 800


Handheld = Garmin etrex 30
