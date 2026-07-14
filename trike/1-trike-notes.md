Notes on Trike map creation  
===========================  

Filtering the ways and areas etc so we only have what we want to include
------------------------------------------------------------------------

Preparing the raw data for map production. Trike will use Roads, bridleways, tracks and paths marked as cycle use. We're not interested in 'ways' which are marked as private, customers only, or any other way not allowing access.  

**Area 1** parameters-1 = Highways and any ways that a cycle could navigate on.

**Area 2** parameters-2 = Landuse, addresses, shops etc. Features that make the map look good - barriers deleted from these.

**Area 3** after combining Area 1 & Area 2



Speeds
--------

changed with 
  road_speed=0-7
where 7 is the fastest

7=ncn
6=rcn
5=lcn and some faster roads with cyclways
