Notes on Trike map creation  
===========================  

Filtering the ways and areas etc so we only have what we want to include
------------------------------------------------------------------------

Preparing the raw data for map production. Trike will use Roads, bridleways, tracks and paths marked as cycle use. We're not interested in 'ways' which are marked as private, customers only, or any other way not allowing access.  

**Area 1** parameters-1 = items with barrier nodes included - All ways that a cycle could use, but drops those ways not wide enough for the trike to fit.  

**Area 2** parameters-2 = items without barrier nodes - All areas that are wanted, such as grass, rivers, some shops, railways, etc, but drops the barriers attached to them - we are only interested in barriers on the highways etc allowed by parameters 1.  

**Area 3** after combining Area 1 & Area 2

**Area 4** from Area 3 after filter by bar-parameters-1 selects = all highways, except those that may be private - allows those with a tag allowing a cycle to go along them. 

**Area 5** from Area 3 after filter by bar-parameters-2 = Private Customer access areas with barriers dropped - you can see the 'way' but you won't be going along it because of the access restrictions.  

**Area 6** is Areas 4 & 5 combined. We now have only the ways and areas we are interested in, with only the barriers we want (for instance not interested in a gate to a field which has not road to it.).


Speeds
--------

changed with 
  road_speed=0-7
where 7 is the fastest

7=ncn
6=rcn
5=lcn and some faster roads with cyclways
