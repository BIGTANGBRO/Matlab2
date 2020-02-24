C:
cd C:\Program Files\FlightGear 3.4.0

SET FG_ROOT=C:\Program Files\FlightGear 3.4.0\data
.\\bin\fgfs --aircraft=f16 --fdm=network,localhost,5501,5502,5503 --fog-fastest --disable-clouds --start-date-lat=2004:06:01:09:00:00 --disable-sound --in-air --enable-freeze --airport=KSFO --runway=28L --altitude=5000 --heading=113 --offset-distance=4.72 --offset-azimuth=0
