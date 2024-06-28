# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Aos.Repo.insert!(%Aos.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Aos.Repo.{PlayerRepo, PortRepo, RouteRepo}

{:ok, player} = PlayerRepo.create(%{email: "demo@demo.com", password: "password"})

{:ok, london} = PortRepo.create("London", "LOND")
{:ok, port_of_spain} = PortRepo.create("Port of Spain", "PTOS")
{:ok, amsterdam} = PortRepo.create("Amsterdam", "AMST")
{:ok, lisbon} = PortRepo.create("Lisbon", "LISB")
{:ok, antwerp} = PortRepo.create("Antwerp", "ANTW")
{:ok, seville} = PortRepo.create("Seville", "SEVL")
{:ok, venice} = PortRepo.create("Venice", "VNCE")
{:ok, genoa} = PortRepo.create("Genoa", "GENA")
{:ok, hamburg} = PortRepo.create("Hamburg", "HAMG")
{:ok, bordeaux} = PortRepo.create("Bordeaux", "BORD")
{:ok, marseille} = PortRepo.create("Marseille", "MRSI")
{:ok, istanbul} = PortRepo.create("Istanbul", "ISTB")
{:ok, havana} = PortRepo.create("Havana", "HAVN")
{:ok, san_juan} = PortRepo.create("San Juan", "SJUN")
{:ok, santo_domingo} = PortRepo.create("Santo Domingo", "SNDM")
{:ok, port_royal} = PortRepo.create("Port Royal", "PRYL")
{:ok, port_of_spain} = PortRepo.create("Port of Spain", "PTOS")

{:ok, london_to_port_of_spain} =
  RouteRepo.create(london, port_of_spain, "London -> Port of Spain", 1)

{:ok, amsterdam_to_lisbon} =
  RouteRepo.create(amsterdam, lisbon, "Amsterdam -> Lisbon", 2)

{:ok, amsterdam_to_london} =
  RouteRepo.create(amsterdam, london, "Amsterdam -> London", 1)

{:ok, amsterdam_to_antwerp} =
  RouteRepo.create(amsterdam, antwerp, "Amsterdam -> Antwerp", 1)

{:ok, amsterdam_to_seville} =
  RouteRepo.create(amsterdam, seville, "Amsterdam -> Seville", 4)

{:ok, amsterdam_to_venice} =
  RouteRepo.create(amsterdam, venice, "Amsterdam -> Venice", 3)

{:ok, amsterdam_to_genoa} =
  RouteRepo.create(amsterdam, genoa, "Amsterdam -> Genoa", 3)

{:ok, amsterdam_to_hamburg} =
  RouteRepo.create(amsterdam, hamburg, "Amsterdam -> Hamburg", 1)

{:ok, amsterdam_to_bordeaux} =
  RouteRepo.create(amsterdam, bordeaux, "Amsterdam -> Bordeaux", 2)

{:ok, amsterdam_to_marseille} =
  RouteRepo.create(amsterdam, marseille, "Amsterdam -> Marseille", 3)

{:ok, amsterdam_to_istanbul} =
  RouteRepo.create(amsterdam, istanbul, "Amsterdam -> Istanbul", 6)

{:ok, amsterdam_to_havana} =
  RouteRepo.create(amsterdam, havana, "Amsterdam -> Havana", 12)

{:ok, amsterdam_to_san_juan} =
  RouteRepo.create(amsterdam, san_juan, "Amsterdam -> San Juan", 12)

{:ok, amsterdam_to_santo_domingo} =
  RouteRepo.create(amsterdam, santo_domingo, "Amsterdam -> Santo Domingo", 12)

{:ok, amsterdam_to_port_royal} =
  RouteRepo.create(amsterdam, port_royal, "Amsterdam -> Port Royal", 12)

{:ok, amsterdam_to_port_of_spain} =
  RouteRepo.create(amsterdam, port_of_spain, "Amsterdam -> Port of Spain", 12)

{:ok, lisbon_to_london} =
  RouteRepo.create(lisbon, london, "Lisbon -> London", 2)

{:ok, lisbon_to_antwerp} =
  RouteRepo.create(lisbon, antwerp, "Lisbon -> Antwerp", 2)

{:ok, lisbon_to_seville} =
  RouteRepo.create(lisbon, seville, "Lisbon -> Seville", 1)

{:ok, lisbon_to_venice} =
  RouteRepo.create(lisbon, venice, "Lisbon -> Venice", 4)

{:ok, lisbon_to_genoa} =
  RouteRepo.create(lisbon, genoa, "Lisbon -> Genoa", 4)

{:ok, lisbon_to_hamburg} =
  RouteRepo.create(lisbon, hamburg, "Lisbon -> Hamburg", 3)

{:ok, lisbon_to_bordeaux} =
  RouteRepo.create(lisbon, bordeaux, "Lisbon -> Bordeaux", 1)

{:ok, lisbon_to_marseille} =
  RouteRepo.create(lisbon, marseille, "Lisbon -> Marseille", 2)

{:ok, lisbon_to_istanbul} =
  RouteRepo.create(lisbon, istanbul, "Lisbon -> Istanbul", 6)

{:ok, lisbon_to_havana} =
  RouteRepo.create(lisbon, havana, "Lisbon -> Havana", 10)

{:ok, lisbon_to_san_juan} =
  RouteRepo.create(lisbon, san_juan, "Lisbon -> San Juan", 10)

{:ok, lisbon_to_santo_domingo} =
  RouteRepo.create(lisbon, santo_domingo, "Lisbon -> Santo Domingo", 10)

{:ok, lisbon_to_port_royal} =
  RouteRepo.create(lisbon, port_royal, "Lisbon -> Port Royal", 10)

{:ok, lisbon_to_port_of_spain} =
  RouteRepo.create(lisbon, port_of_spain, "Lisbon -> Port of Spain", 10)

{:ok, london_to_antwerp} =
  RouteRepo.create(london, antwerp, "London -> Antwerp", 1)

{:ok, london_to_seville} =
  RouteRepo.create(london, seville, "London -> Seville", 3)

{:ok, london_to_venice} =
  RouteRepo.create(london, venice, "London -> Venice", 4)

{:ok, london_to_genoa} =
  RouteRepo.create(london, genoa, "London -> Genoa", 4)

{:ok, london_to_hamburg} =
  RouteRepo.create(london, hamburg, "London -> Hamburg", 1)

{:ok, london_to_bordeaux} =
  RouteRepo.create(london, bordeaux, "London -> Bordeaux", 2)

{:ok, london_to_marseille} =
  RouteRepo.create(london, marseille, "London -> Marseille", 3)

{:ok, london_to_istanbul} =
  RouteRepo.create(london, istanbul, "London -> Istanbul", 6)

{:ok, london_to_havana} =
  RouteRepo.create(london, havana, "London -> Havana", 12)

{:ok, london_to_san_juan} =
  RouteRepo.create(london, san_juan, "London -> San Juan", 12)

{:ok, london_to_santo_domingo} =
  RouteRepo.create(london, santo_domingo, "London -> Santo Domingo", 12)

{:ok, london_to_port_royal} =
  RouteRepo.create(london, port_royal, "London -> Port Royal", 12)

{:ok, london_to_port_of_spain} =
  RouteRepo.create(london, port_of_spain, "London -> Port of Spain", 12)

{:ok, antwerp_to_seville} =
  RouteRepo.create(antwerp, seville, "Antwerp -> Seville", 3)

{:ok, antwerp_to_venice} =
  RouteRepo.create(antwerp, venice, "Antwerp -> Venice", 4)

{:ok, antwerp_to_genoa} =
  RouteRepo.create(antwerp, genoa, "Antwerp -> Genoa", 4)

{:ok, antwerp_to_hamburg} =
  RouteRepo.create(antwerp, hamburg, "Antwerp -> Hamburg", 1)

{:ok, antwerp_to_bordeaux} =
  RouteRepo.create(antwerp, bordeaux, "Antwerp -> Bordeaux", 2)

{:ok, antwerp_to_marseille} =
  RouteRepo.create(antwerp, marseille, "Antwerp -> Marseille", 3)

{:ok, antwerp_to_istanbul} =
  RouteRepo.create(antwerp, istanbul, "Antwerp -> Istanbul", 6)

{:ok, antwerp_to_havana} =
  RouteRepo.create(antwerp, havana, "Antwerp -> Havana", 12)

{:ok, antwerp_to_san_juan} =
  RouteRepo.create(antwerp, san_juan, "Antwerp -> San Juan", 12)

{:ok, antwerp_to_santo_domingo} =
  RouteRepo.create(antwerp, santo_domingo, "Antwerp -> Santo Domingo", 12)

{:ok, antwerp_to_port_royal} =
  RouteRepo.create(antwerp, port_royal, "Antwerp -> Port Royal", 12)

{:ok, antwerp_to_port_of_spain} =
  RouteRepo.create(antwerp, port_of_spain, "Antwerp -> Port of Spain", 12)

{:ok, seville_to_venice} =
  RouteRepo.create(seville, venice, "Seville -> Venice", 3)

{:ok, seville_to_genoa} =
  RouteRepo.create(seville, genoa, "Seville -> Genoa", 3)

{:ok, seville_to_hamburg} =
  RouteRepo.create(seville, hamburg, "Seville -> Hamburg", 4)

{:ok, seville_to_bordeaux} =
  RouteRepo.create(seville, bordeaux, "Seville -> Bordeaux", 2)

{:ok, seville_to_marseille} =
  RouteRepo.create(seville, marseille, "Seville -> Marseille", 2)

{:ok, seville_to_istanbul} =
  RouteRepo.create(seville, istanbul, "Seville -> Istanbul", 5)

{:ok, seville_to_havana} =
  RouteRepo.create(seville, havana, "Seville -> Havana", 8)

{:ok, seville_to_san_juan} =
  RouteRepo.create(seville, san_juan, "Seville -> San Juan", 8)

{:ok, seville_to_santo_domingo} =
  RouteRepo.create(seville, santo_domingo, "Seville -> Santo Domingo", 8)

{:ok, seville_to_port_royal} =
  RouteRepo.create(seville, port_royal, "Seville -> Port Royal", 8)

{:ok, seville_to_port_of_spain} =
  RouteRepo.create(seville, port_of_spain, "Seville -> Port of Spain", 8)

{:ok, venice_to_genoa} =
  RouteRepo.create(venice, genoa, "Venice -> Genoa", 1)

{:ok, venice_to_hamburg} =
  RouteRepo.create(venice, hamburg, "Venice -> Hamburg", 3)

{:ok, venice_to_bordeaux} =
  RouteRepo.create(venice, bordeaux, "Venice -> Bordeaux", 4)

{:ok, venice_to_marseille} =
  RouteRepo.create(venice, marseille, "Venice -> Marseille", 3)

{:ok, venice_to_istanbul} =
  RouteRepo.create(venice, istanbul, "Venice -> Istanbul", 4)

{:ok, venice_to_havana} =
  RouteRepo.create(venice, havana, "Venice -> Havana", 13)

{:ok, venice_to_san_juan} =
  RouteRepo.create(venice, san_juan, "Venice -> San Juan", 13)

{:ok, venice_to_santo_domingo} =
  RouteRepo.create(venice, santo_domingo, "Venice -> Santo Domingo", 13)

{:ok, venice_to_port_royal} =
  RouteRepo.create(venice, port_royal, "Venice -> Port Royal", 13)

{:ok, venice_to_port_of_spain} =
  RouteRepo.create(venice, port_of_spain, "Venice -> Port of Spain", 13)

{:ok, genoa_to_hamburg} =
  RouteRepo.create(genoa, hamburg, "Genoa -> Hamburg", 3)

{:ok, genoa_to_bordeaux} =
  RouteRepo.create(genoa, bordeaux, "Genoa -> Bordeaux", 4)

{:ok, genoa_to_marseille} =
  RouteRepo.create(genoa, marseille, "Genoa -> Marseille", 2)

{:ok, genoa_to_istanbul} =
  RouteRepo.create(genoa, istanbul, "Genoa -> Istanbul", 4)

{:ok, genoa_to_havana} =
  RouteRepo.create(genoa, havana, "Genoa -> Havana", 13)

{:ok, genoa_to_san_juan} =
  RouteRepo.create(genoa, san_juan, "Genoa -> San Juan", 13)

{:ok, genoa_to_santo_domingo} =
  RouteRepo.create(genoa, santo_domingo, "Genoa -> Santo Domingo", 13)

{:ok, genoa_to_port_royal} =
  RouteRepo.create(genoa, port_royal, "Genoa -> Port Royal", 13)

{:ok, genoa_to_port_of_spain} =
  RouteRepo.create(genoa, port_of_spain, "Genoa -> Port of Spain", 13)

{:ok, hamburg_to_bordeaux} =
  RouteRepo.create(hamburg, bordeaux, "Hamburg -> Bordeaux", 2)

{:ok, hamburg_to_marseille} =
  RouteRepo.create(hamburg, marseille, "Hamburg -> Marseille", 3)

{:ok, hamburg_to_istanbul} =
  RouteRepo.create(hamburg, istanbul, "Hamburg -> Istanbul", 5)

{:ok, hamburg_to_havana} =
  RouteRepo.create(hamburg, havana, "Hamburg -> Havana", 14)

{:ok, hamburg_to_san_juan} =
  RouteRepo.create(hamburg, san_juan, "Hamburg -> San Juan", 14)

{:ok, hamburg_to_santo_domingo} =
  RouteRepo.create(hamburg, santo_domingo, "Hamburg -> Santo Domingo", 14)

{:ok, hamburg_to_port_royal} =
  RouteRepo.create(hamburg, port_royal, "Hamburg -> Port Royal", 14)

{:ok, hamburg_to_port_of_spain} =
  RouteRepo.create(hamburg, port_of_spain, "Hamburg -> Port of Spain", 14)

{:ok, bordeaux_to_marseille} =
  RouteRepo.create(bordeaux, marseille, "Bordeaux -> Marseille", 2)

{:ok, bordeaux_to_istanbul} =
  RouteRepo.create(bordeaux, istanbul, "Bordeaux -> Istanbul", 5)

{:ok, bordeaux_to_havana} =
  RouteRepo.create(bordeaux, havana, "Bordeaux -> Havana", 12)

{:ok, bordeaux_to_san_juan} =
  RouteRepo.create(bordeaux, san_juan, "Bordeaux -> San Juan", 12)

{:ok, bordeaux_to_santo_domingo} =
  RouteRepo.create(bordeaux, santo_domingo, "Bordeaux -> Santo Domingo", 12)

{:ok, bordeaux_to_port_royal} =
  RouteRepo.create(bordeaux, port_royal, "Bordeaux -> Port Royal", 12)

{:ok, bordeaux_to_port_of_spain} =
  RouteRepo.create(bordeaux, port_of_spain, "Bordeaux -> Port of Spain", 12)

{:ok, marseille_to_istanbul} =
  RouteRepo.create(marseille, istanbul, "Marseille -> Istanbul", 4)

{:ok, marseille_to_havana} =
  RouteRepo.create(marseille, havana, "Marseille -> Havana", 13)

{:ok, marseille_to_san_juan} =
  RouteRepo.create(marseille, san_juan, "Marseille -> San Juan", 13)

{:ok, marseille_to_santo_domingo} =
  RouteRepo.create(marseille, santo_domingo, "Marseille -> Santo Domingo", 13)

{:ok, marseille_to_port_royal} =
  RouteRepo.create(marseille, port_royal, "Marseille -> Port Royal", 13)

{:ok, marseille_to_port_of_spain} =
  RouteRepo.create(marseille, port_of_spain, "Marseille -> Port of Spain", 13)

{:ok, istanbul_to_havana} =
  RouteRepo.create(istanbul, havana, "Istanbul -> Havana", 14)

{:ok, istanbul_to_san_juan} =
  RouteRepo.create(istanbul, san_juan, "Istanbul -> San Juan", 14)

{:ok, istanbul_to_santo_domingo} =
  RouteRepo.create(istanbul, santo_domingo, "Istanbul -> Santo Domingo", 14)

{:ok, istanbul_to_port_royal} =
  RouteRepo.create(istanbul, port_royal, "Istanbul -> Port Royal", 14)

{:ok, istanbul_to_port_of_spain} =
  RouteRepo.create(istanbul, port_of_spain, "Istanbul -> Port of Spain", 14)

{:ok, havana_to_san_juan} =
  RouteRepo.create(havana, san_juan, "Havana -> San Juan", 1)

{:ok, havana_to_santo_domingo} =
  RouteRepo.create(havana, santo_domingo, "Havana -> Santo Domingo", 1)

{:ok, havana_to_port_royal} =
  RouteRepo.create(havana, port_royal, "Havana -> Port Royal", 1)

{:ok, havana_to_port_of_spain} =
  RouteRepo.create(havana, port_of_spain, "Havana -> Port of Spain", 2)

{:ok, san_juan_to_santo_domingo} =
  RouteRepo.create(san_juan, santo_domingo, "San Juan -> Santo Domingo", 1)

{:ok, san_juan_to_port_royal} =
  RouteRepo.create(san_juan, port_royal, "San Juan -> Port Royal", 1)

{:ok, san_juan_to_port_of_spain} =
  RouteRepo.create(san_juan, port_of_spain, "San Juan -> Port of Spain", 2)

{:ok, santo_domingo_to_port_royal} =
  RouteRepo.create(santo_domingo, port_royal, "Santo Domingo -> Port Royal", 1)

{:ok, santo_domingo_to_port_of_spain} =
  RouteRepo.create(santo_domingo, port_of_spain, "Santo Domingo -> Port of Spain", 2)

{:ok, port_royal_to_port_of_spain} =
  RouteRepo.create(port_royal, port_of_spain, "Port Royal -> Port of Spain", 2)
