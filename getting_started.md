# Age Of Sail - Getting started

# Setup
First register a player and a company for that player.

## Company Agent
Company Agents represent the players company in a port, they take actions directed by the company and can buy, sell and trade.

## Warehouse
The warehouse is where you store bought or traded goods. You buy a warehouse and it comes with an initial amount of space, as you scale up the warehouse the cost to maintain it goes up.

## Shipyard
The shipyard provides a location where ships are built and sold. Agents can buy a ship in a port and that ship can transport goods between ports.

## Trader
Traders are NPC agents that sell locally produced goods and buy externally produced goods at a local price.

## Market
The market is a player run marketboard where goods can be bought and sold in port between players. It works like an order book. The market board has a fee attached.

## Taxes
Each port charges a sales tax on goods sold in port to a trader. Currently this is a fixed value in each port.

## Gametime
Time increments via a tick. The ratio of realtime to game time is 1:0.00104167
this means that 1 second of real time is the same as 960 seconds of game time.

The game runs on a daily tick rate. This means that every 90 seconds a day passes.

You can work out what in game day it is by simply subtracing now from the start date. Multiply that by the scalar value
