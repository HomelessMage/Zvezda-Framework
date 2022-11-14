--jar lids do not come as 6

if not VendISWorldObjectContextMenu then VendISWorldObjectContextMenu = {}; end

local vendMoney = 0;
local moneyTypes = {"Money", "OneDollar", "1Dollar", "5Dollar", "TenDollar", "10Dollar", "20Dollar", "HundredDollar", "100Dollar", "ThousandDollar", "1KDollar", "2KDollar", "10KDollar", "20KDollar", "100KDollar"}

local moneyContainer = {};
local vendorsFanLeaf = 0;

local vendorsSaleTotal = 0;
local vendorList = nil;

local vendorWallet = {};
vendorsJewelry = {};
vendorsJewelry.prices = {};
vendorsJewelry.prices.tags = 50;
vendorsJewelry.prices.stones = 25;
vendorsJewelry.prices.regular = 10;
vendorsJewelry.stones = {};
vendorsJewelry.regular = {};
vendorsJewelry.tags = {};
vendorsTools = {};
vendorsVehicles = {};
vendorsWeapons = {};
vendorsJewelry.green = {};
vendorsBooks = {};

-----------  SELL ITEMS -----  If you want to add items to the list of items you can sell, put them in this list.
--- EXAMPLE  -- {"itemType", price} {"BaseballBat", 30}  Make sure there is a comma between each item...  vendorsSellables = {{"BaseballBat", 30}, {"Book", 10}};
vendorsSellables = {
	-- Мусор
	{"AppleCore", 2}, {"BakingSodaEmpty", 2}, {"BananaPeel", 2}, {"BoneScraps", 2}, {"BrownSugarEmpty", 2}, {"CakeCartonEmpty", 2}, {"CandyPackageEmpty", 2}, {"CerealEmpty", 2}, {"CheeseWrapper", 2}, {"ChocolateWrapper", 2}, {"CocoaPowderEmpty", 2}, {"CoffeeEmpty", 2}, {"CrispsEmpty", 2}, {"Crisps2Empty", 2}, {"Crisps3Empty", 2}, {"Crisps4Empty", 2}, {"DriedBlackBeansEmpty", 2}, {"DriedChickpeasEmpty", 2}, {"DriedKidneyBeansEmpty", 2}, {"DriedLentilsEmpty", 2}, {"DriedSplitPeasEmpty", 2}, {"DriedWhiteBeansEmpty", 2}, {"EggCartonEmpty", 2}, {"EggShells", 2}, {"FlourEmpty", 2}, {"FriesCartonEmpty", 2}, {"FruitRindLemon", 2}, {"FruitRindLime", 2}, {"FruitRindMelon", 2}, {"FruitRindOrange", 2}, {"FruitRindPineapple", 2}, {"GravyBoat", 2}, {"GravyMixEmpty", 2}, {"GumWrapper", 2}, {"HoneyBottleEmpty", 2}, {"HoneyBottleWater", 2}, {"HotsauceBottleEmpty", 2}, {"HotsauceBottleWater", 2}, {"JamFruitEmpty", 2}, {"JamMarmaladeEmpty", 2}, {"JuiceBoxEmpty", 2}, {"KetchupEmpty", 2}, {"LollipopStick", 2}, {"MacBoxEmpty", 2}, {"MapleSyrupEmpty", 2}, {"MapleSyrupWater", 2}, {"MarinaraEmpty", 2}, {"MilkEmpty", 2}, {"MintCandyWrapper", 2}, {"MustardEmpty", 2}, {"OilVegetableEmpty", 2}, {"OilVegetableWater", 2}, {"PancakeMixEmpty", 2}, {"PeanutButterEmpty", 2}, {"PeanutShells", 2}, {"PeasEmpty", 2}, {"PieCartonEmpty", 2}, {"PlasticWrapperGeneric", 2}, {"PopcornBagEmpty", 2}, {"RiceBagEmpty", 2}, {"RiceVinegarEmpty", 2}, {"RiceVinegarWater", 2}, {"SoysauceEmpty", 2}, {"SoysauceWater", 2}, {"SugarEmpty", 2}, {"SunflowerShells", 2}, {"TeaBox", 2}, {"TeaBoxEmpty", 2}, {"TubIcecreamEmpty", 2}, {"TVDinnerPackage", 2}, {"UsedTeabag", 2}, {"VinegarEmpty", 2}, {"VinegarWater", 2}, {"YogurtEmpty", 2}, {"CornCob", 2}, {"FruitPits", 2}, {"SaltShakerEmpty", 2}, {"PepperShakerEmpty", 2}, {"SpaghetBoxEmpty", 2}, {"CanOfOatsEmpty", 2}, {"OliveOilEmpty", 2}, {"OliveOilWater", 2}, {"CornflourEmpty", 2}, {"YeastPacketEmpty", 2}, {"AlcoholWipesEmpty", 2}, {"AntibioticsBlisterEmpty", 2}, {"AntidepressantsEmpty", 2}, {"BandaidDirty", 2}, {"BetaBlockersEmpty", 2}, {"DisinfectantEmpty", 2}, {"DisinfectantWater", 2}, {"PainkillersEmpty", 2}, {"SleepingPillsEmpty", 2}, {"VitaminsEmpty", 2}, {"TissueUsed", 2}, {"CologneEmpty", 2}, {"HairDyeBlackEmpty", 2}, {"HairDyeBlondeEmpty", 2}, {"HairDyeBlueEmpty", 2}, {"HairDyeBrownEmpty", 2}, {"HairDyeGingerEmpty", 2}, {"HairDyeGreenEmpty", 2}, {"HairDyePinkEmpty", 2}, {"HairDyeRedEmpty", 2}, {"HairDyeWhiteEmpty", 2}, {"HairDyeYellowEmpty", 2}, {"LipstickTubeEmpty", 2}, {"MakeupEyeshadowEmpty", 2}, {"MakeupFoundationEmpty", 2}, {"PerfumeEmpty", 2}, {"BagOfCharcoalEmpty", 2}, {"CardboardFlat", 2}, {"CleaningLiquidEmpty", 2}, {"CleaningLiquidWater", 2}, {"ConcretePowderEmpty", 2}, {"DuctTapeEmpty", 2}, {"EmptyNailsBox", 2}, {"EmptyPaperclipBox", 2}, {"EmptyScrewsBox", 2}, {"FishingLineEmpty", 2}, {"GlueEmpty", 2}, {"GunpowderJarEmpty", 2}, {"MatchesEmpty", 2}, {"LighterEmpty", 2}, {"PlasterPowderEmpty", 2}, {"ScotchtapeEmpty", 2}, {"SparklerBoxEmpty", 2}, {"ThreadSpool", 2}, {"ToiletPaperEmpty", 2}, {"TwineSpool", 2}, {"WeldingRodsEmpty", 2}, {"WoodGlueEmpty", 2}, {"ExtinguisherEmpty", 2}, {"BookTorn", 2}, {"ComicBookTorn", 2}, {"Crossword1Used", 2}, {"Crossword2Used", 2}, {"Crossword3Used", 2}, {"MagazineNudie1Gross", 2}, {"MagazineTorn", 2}, {"NewspaperTorn", 2}, {"WordSearch1Used", 2}, {"WordSearch2Used", 2}, {"WordSearch3Used", 2}, {"BroccoliSeedsPacketEmpty", 2}, {"CabbageSeedsPacketEmpty", 2}, {"CarrotSeedsPacketEmpty", 2}, {"PotatoSeedsPacketEmpty", 2}, {"RadishSeedsPacketEmpty", 2}, {"StrawberrySeedsPacketEmpty", 2}, {"TomatoSeedsPacketEmpty", 2}, {"9mmAmmoBoxEmpty", 2}, {"38AmmoBoxEmpty", 2}, {"44AmmoBoxEmpty", 2}, {"45AmmoBoxEmpty", 2}, {"223AmmoBoxEmpty", 2}, {"308AmmoBoxEmpty", 2}, {"556AmmoBoxEmpty", 2}, {"ShotgunAmmoBoxEmpty", 2}, {"CigaretteButt", 2}, {"CorndogStick", 2},
	-- Овощи
	{"SackProduce_Apple", 30}, {"SackProduce_BellPepper", 30}, {"SackProduce_Broccoli", 30}, {"SackProduce_Cabbage", 30}, {"SackProduce_Carrot", 30}, {"SackProduce_Cherry", 30}, {"SackProduce_Corn", 30}, {"SackProduce_Eggplant", 30}, {"SackProduce_Grapes", 30}, {"SackProduce_Leek", 30}, {"SackProduce_Lettuce", 30}, {"SackProduce_Onion", 30}, {"SackProduce_Peach", 30}, {"SackProduce_Pear", 30}, {"SackProduce_Potato", 30}, {"SackProduce_RedRadish", 30}, {"SackProduce_Strawberry", 30}, {"SackProduce_Tomato", 30}, 
	-- Наркотики
	{"MethGood", 15}, {"MethBad", 5}, {"PepperMethGood", 25}, {"PepperMethBad", 20}, {"BlueMethGood", 40}, {"BlueMethBad", 30}, {"KgCannabis", 1200}, {"GFCigaretteCase", 800}, 
	-- Мебель
	{"morebuild_01_6", 45}, {"morebuild_01_3", 45}, 
	-- Рыба
	{"Bass", 2}, {"Catfish", 2}, {"Crappie", 2}, {"Crayfish", 2}, {"FishFillet", 2}, {"FishRoe", 2}, {"BaitFish", 2}, {"Lobster", 2}, {"Oysters", 2}, {"Perch", 2}, {"Pike", 2}, {"Salmon", 2}, {"Shrimp", 2}, {"Squid", 2}, {"SquidCalamari", 2}, {"Panfish", 2}, {"Trout", 2}};
vendorsSellables.items = {};

-- vendorsBooks[1] = {"GeneralReading", {"Book", 40}, {"ComicBook", 25}, {"HottieZ", 50}, {"Magazine", 25}, {"Newspaper", 15}};
vendorsBooks[1] = {"GeneralReading", {"Newspaper", 15}};
vendorsBooks[2] = {"Magazines_Skill", {"FishingMag1", 50}, {"FishingMag2", 50}, {"ElectronicsMag1", 50}, {"ElectronicsMag2", 50}, {"ElectronicsMag3", 50}, {"ElectronicsMag5", 50}, {"EngineerMagazine1", 50}, {"EngineerMagazine2", 50}, {"CookingMag1", 50}, {"CookingMag2", 50}, {"Radio.RadioMag1", 50}, {"Radio.RadioMag2", 50}, {"Radio.RadioMag3", 50}, {"ElectronicsMag4", 50}, {"MechanicMag1", 50}, {"MechanicMag2", 50}, {"MechanicMag3", 50}, {"FarmingMag1", 50}, {"HerbalistMag", 50}, {"HuntingMag1", 50}, {"HuntingMag2", 50}, {"HuntingMag3", 50}, {"MetalworkMag1", 50}, {"MetalworkMag2", 50}, {"MetalworkMag3", 50}, {"MetalworkMag4", 50}, {"Greenfire.CannaMag1", 50}, {"Greenfire.CannaMag2", 50}, {"Greenfire.CannaMag3", 50}, {"Greenfire.AficMag1", 50}};
-- vendorsBooks[3] = {"Maps", {"MarchRidgeMap", 60}, {"MuldraughMap", 60}, {"RiversideMap", 60}, {"RosewoodMap", 60}, {"WestpointMap", 60}};
-- vendorsBooks[4] = {"SkillBooks", {"BookCarpentry1", 750}, {"BookCarpentry2", 750}, {"BookCarpentry3", 750}, {"BookCarpentry4", 750}, {"BookCarpentry5", 750}, {"BookCooking1", 750}, {"BookCooking2", 750}, {"BookCooking3", 750}, {"BookCooking4", 750}, {"BookCooking5", 750}, {"BookElectrician1", 750}, {"BookElectrician2", 750}, {"BookElectrician3", 750}, {"BookElectrician4", 750}, {"BookElectrician5", 750}, {"BookFarming1", 750}, {"BookFarming2", 750}, {"BookFarming3", 750}, {"BookFarming4", 750}, {"BookFarming5", 750}, {"BookFirstAid1", 750}, {"BookFirstAid2", 750}, {"BookFirstAid3", 750}, {"BookFirstAid4", 750}, {"BookFirstAid5", 750}, {"BookFishing1", 750}, {"BookFishing2", 750}, {"BookFishing3", 750}, {"BookFishing4", 750}, {"BookFishing5", 750}, {"BookForaging1", 750}, {"BookForaging2", 750}, {"BookForaging3", 750}, {"BookForaging4", 750}, {"BookForaging5", 750}, {"BookMechanic1", 750}, {"BookMechanic2", 750}, {"BookMechanic3", 750}, {"BookMechanic4", 750}, {"BookMechanic5", 750}, {"BookMetalWelding1", 750}, {"BookMetalWelding2", 750}, {"BookMetalWelding3", 750}, {"BookMetalWelding4", 750}, {"BookMetalWelding5", 750}, {"BookTrapping1", 750}, {"BookTrapping2", 750}, {"BookTrapping3", 750}, {"BookTrapping4", 750}, {"BookTrapping5", 750}};




-- vendorsTools[1] = {"Camping", {"SharpedStone", 25}, {"Lighter", 45}, {"PercedWood", 50}, {"WoodenStick", 50}};
vendorsTools[1] = {"ZvezdaTools", {"BakingTray",  40}, {"LeadPipe", 15}, {"Scissors", 35}, {"Pot", 60}, {"TinOpener", 25}, {"Bowl", 5}, {"Shovel", 140}, {"farming.HandShovel", 70}, {"FishingRod", 200}, {"Greenfire.SmokingPipe", 20}, {"Greenfire.Bong_pastelblue", 30}};
-- vendorsTools[2] = {"Construction", {"Axe", 100}, {"BucketEmpty", 250}, {"Crowbar", 75}, {"Hammer", 45}, {"Needle", 25}, {"Paintbrush", 25}, {"PropaneTank", 125}, {"BlowTorch", 250}, {"Saw", 75}, {"Screwdriver", 50}, {"AxeStone", 75}, {"HammerStone", 50}, {"WeldingMask", 50}};
vendorsTools[2] = {"ZvezdaMaterials", {"Bleach", 20}, {"Disinfectant", 40}, {"Greenfire.RollingPapers", 20}, {"Greenfire.TobaccoSeed", 7}, {"NailsBox", 50}};
-- vendorsTools[3] = {"Cooking", {"BakingPan", 45}, {"Bowl", 250}, {"BoxOfJars", 50}, {"TinOpener", 50}, {"Pot", 50}, {"Pan", 45}, {"KitchenKnife", 250}, {"Kettle", 50}, {"RollingPin", 25}, {"BakingPan", 50}, {"Saucepan", 50}};
vendorsTools[3] = {"ZvezdaAccessories", {"Hat_Bandana", 25}, {"Hat_Beany", 20}, {"Dungarees", 60}};
-- vendorsTools[4] = {"Farming", {"farming.GardeningSprayEmpty", 75}, {"farming.WateredCan", 100}, {"Fertilizer", 75}, {"EmptySandbag", 25}, {"farming.Shovel", 100}, {"farming.HandShovel", 100}};
-- vendorsTools[5] = {"Fishing", {"FishingNet", 75}, {"FishingRod", 100}, {"FishingTackle", 45}};
-- vendorsTools[6] = {"Light", {"Torch", 75}, {"Matches", 50}}
-- vendorsTools[7] = {"Mechanics", {"PetrolCan", 100}, {"Jack", 75}, {"LugWrench", 75}, {"TirePump", 75}, {"Wrench", 75}};
-- vendorsTools[8] = {"Stationery", {"Notebook", 50}, {"Eraser", 50}, {"Journal", 50}, {"Pen", 50}, {"Pencil", 50}, {"SheetPaper2", 50}};
-- vendorsTools[9] = {"Trapping", {"TrapCage", 75}, {"TrapMouse", 25}, {"TrapSnare", 60}, {"TrapStick", 50}, {"TrapBox", 60}, {"TrapCrate", 60}};

vendorsVehicles = {};
vendorsVehicles.parts = {};
vendorsVehicles.parts[1] = {"Standard", {"CarBattery1", 250}, {"FrontCarDoor1", 250}, {"EngineDoor1", 250}, {"ModernBrake1", 250}, {"TrunkDoor1", 250}, {"RearCarDoor1", 250}, {"RearCarDoorDouble1", 250}, {"BigGasTank1", 250}, {"ModernCarMuffler1", 250}, {"NormalCarSeat1", 250}, {"ModernSuspension1", 250}, {"ModernTire1", 250}, {"Windshield1", 250}, {"RearWindshield1", 250}, {"FrontWindow1", 250}, {"RearWindow1", 250}};
vendorsVehicles.parts[2] = {"Sport", {"CarBattery3", 500}, {"FrontCarDoor3", 500}, {"EngineDoor3", 500}, {"ModernBrake3", 500}, {"TrunkDoor3", 500}, {"RearCarDoor3", 500}, {"RearCarDoorDouble3", 500}, {"BigGasTank3", 500}, {"ModernCarMuffler3", 500}, {"NormalCarSeat3", 500}, {"ModernSuspension3", 500}, {"ModernTire3", 500}, {"Windshield3", 500}, {"RearWindshield3", 500}, {"FrontWindow3", v}, {"RearWindow3", 500}};
vendorsVehicles.parts[3] = {"Heavy-Duty", {"CarBattery2", 1000}, {"FrontCarDoor2", 1000}, {"EngineDoor2", 1000}, {"ModernBrake2", 1000}, {"TrunkDoor2", 1000}, {"RearCarDoor2", 1000}, {"RearCarDoorDouble2", 1000}, {"BigGasTank2", 1000}, {"ModernCarMuffler2", 1000}, {"NormalCarSeat2", 1000}, {"ModernSuspension2", 1000}, {"ModernTire2", 1000}, {"Windshield2", 1000}, {"RearWindshield2", 1000}, {"FrontWindow2", 1000}, {"RearWindow2", 1000}};
vendorsVehicles.engineParts = {500, 30};
vendorsVehicles.vehicles = {};
-- vendorsVehicles.vehicles.base = {"Vehicles", {{"CarStationWagon", "CarStationWagon2"}, 35000}, {{"SportsCar", "SportsCar_ez"}, 35000}, {{"PickUpTruck", "PickUpTruckLightsFire", "PickUpTruckLights", "PickUpTruckMccoy"}, 35000}, {{"SmallCar"}, 20000}, {{"CarNormal", "CarLights", "CarLightsPolice", "CarTaxi", "CarTaxi2"}, 35000}, {{"ModernCar02"}, 20000}, {{"StepVan", "StepVanMail", "StepVan_Heralds", "StepVan_Scarlet"}, 20000}, {{"PickUpVan", "PickUpVanLights", "PickUpVanLightsFire", "PickUpVanLightsPolice", "PickUpVanMccoy"}, 20000}, {{"ModernCar"}, 20000}, {{"OffRoad"}, 20000}, {{"SUV"}, 20000}, {{"Van", "VanSeats", "VanAmbulance", "VanRadio", "VanRadio_3N", "VanSpiffo", "Van_Transit", "Van_MassGenFac", "VanKnoxDisti", "Van_LectroMax", "VanSpecial"}, 20000}, {{"SmallCar02"}, 15000}, {{"CarLuxury"}, 15000}, {{"Trailer", "TrailerCover"}, 10000}, {{"TrailerAdvert"}, 5000}};
vendorsVehicles.vehicles.base = {"Vehicles", {{"Trailer", "TrailerCover"}, 10000}, {{"TrailerAdvert"}, 5000}};


vendorsWeapons = {};
vendorsWeapons[1] = {"Box_Ammo", {"ShotgunShellsBox", 150, true}, {"223Box", 250, true}, {"308Box", 250, true}, {"Bullets38Box", 100, true}, {"Bullets45Box", 100, true}, {"556Box", 200, true}, {"Bullets9mmBox", 100, true}};
vendorsWeapons[2] = {"Magazines", {"223Clip", 300, false, ".223-REM"}, {"308Clip", 300, false, ".308"}, {"44Clip", 250, false, ".44-MAG"}, {"45Clip", 250, false, ".45 Auto"}, {"556Clip", 350, false, "5.56"}, {"M14Clip", 300, false, ".308"}, {"9mmClip", 300, false, "9mm"}};
-- vendorsWeapons[3] = {"Attachments", {"ChokeTubeImproved", 200, false, "Barrel"}, {"FiberglassStock", 150, false, "Stock"}, {"IronSight", 100, false, "Sight"}, {"Laser", 200, false, "Side"}, {"RecoilPad", 100, false, "Stock"}, {"RedDot", 200, false, "Sight"}, {"Sling", 150, false, "Bottom"}, {"x2Scope", 300, false, "Sight"}, {"x4Scope", 350, false, "Sight"}, {"x8Scope", 400, false, "Sight"}};
-- vendorsWeapons[4] = {"Caliber", ".223-REM", ".308", ".44-MAG", ".45 Auto", "5.56", "9mm"};
-- vendorsWeapons[5] = {"Pistols", {"Pistol", 2500, false, "9mm"}, {"Pistol2", 3000, false, ".45 Auto"}, {"Pistol3", 3000, false, ".44-MAG"}, {"Revolver_Long", 2000, false, ".44-MAG"}, {"Revolver", 2000, false, ".45 Auto"}, {"Revolver_Short", 1500, false, ".38-SPC"}};
-- vendorsWeapons[6] = {"Shotguns", {"DoubleBarrelShotgun", 750, false, "12g"}, {"Shotgun", 2500, false, "12g"}};
-- vendorsWeapons[7] = {"Rifles", {"AssaultRifle2", 7500, false, ".308"}, {"AssaultRifle",  10000, false, "5.56"}, {"VarmintRifle", 3500, false, ".223-REM"}, {"HuntingRifle", 4500, false, ".308"}};
-- vendorsWeapons[8] = {"Slots", "Barrel", "Bottom", "Side", "Sight", "Stock"};

vendorsFoods = {};
-- vendorsFoods[1] = {"Canned_Goods", {"TinnedBeans", 50}, {"CannedChili", 50}, {"CannedCorn", 50}, {"CannedCornedBeef", 50}, {"CannedFruitCocktail", 50}, {"CannedMushroomSoup", 50}, {"CannedPeaches", 50}, {"CannedPeas", 50}, {"CannedPineapple", 50}, {"CannedPotato2", 50}, {"CannedSardines", 50}, {"TinnedSoup", 50}, {"CannedBolognese", 50}, {"CannedTomato2", 50}, {"TunaTin", 50}};
vendorsFoods[1] = {"Appetizers", {"GranolaBar", 50}, {"Chocolate", 50}, {"Crisps", 50}, {"Ramen", 30}};
vendorsFoods[2] = {"Condiments", {"SugarBrown", 10}, {"Hotsauce", 10}, {"Ketchup", 10}, {"MapleSyrup", 10}, {"Marinara", 10}, {"farming.MayonnaiseFull", 10}, {"Mustard", 10}, {"OilOlive", 10}, {"Pepper", 10}, {"RiceVinegar", 10}, {"Salt", 10}, {"Soysauce", 10}, {"Sugar", 10}, {"OilVegetable", 10}, {"Wasabi", 10}};
-- vendorsFoods[3] = {"Drinks", {"BeerBottle", 60}, {"BeerCan", 60}, {"Bleach", 60}, {"WhiskeyFull", 60}, {"ColdDrinkSpiffo", 60}, {"Mugfull", 60}, {"HotDrinkTea", 60}, {"OilOlive", 60}, {"JuiceBox", 60}, {"Milk", 60}, {"PopBottle", 60}, {"Wine2", 60}, {"Wine", 60}};
vendorsFoods[3] = {"Drinks", {"JuiceBox", 50}, {"PopBottle", 50}};
-- vendorsFoods[4] = {"Fish", {"Bass", 75}, {"Catfish", 75}, {"Crappie", 75}, {"Crayfish", 75}, {"FishFillet", 75}, {"FishRoe", 75}, {"BaitFish", 75}, {"Lobster", 75}, {"Oysters", 75}, {"Perch", 75}, {"Pike", 75}, {"Salmon", 75}, {"Shrimp", 75}, {"Squid", 75}, {"SquidCalamari", 75}, {"Panfish", 75}, {"Trout", 75}};
-- vendorsFoods[5] = {"Game", {"DeadBird", 40}, {"DeadMouse", 40}, {"DeadRabbit", 40}, {"DeadRat", 40}, {"DeadSquirrel", 40}, {"Rabbitmeat", 40}, {"Smallanimalmeat", 40}, {"Smallbirdmeat", 40}};
-- vendorsFoods[6] = {"Pickled_Food", {"CannedBellPepper", 40}, {"CannedBroccoli", 40}, {"CannedCabbage", 40}, {"CannedCarrots", 40}, {"CannedEggplant", 40}, {"CannedLeek", 40}, {"CannedPotato", 40}, {"CannedRedRadish", 40}, {"CannedTomato", 40}};
-- vendorsFoods[7] = {"Proteins", {"farming.Bacon", 100}, {"BeefJerky", 100}, {"Chicken", 100}, {"EggCarton", 100}, {"FrogMeat", 100}, {"Ham", 100}, {"MeatPatty", 100}, {"MincedMeat", 100}, {"MuttonChop", 100}, {"Pepperoni", 100}, {"PorkChop", 100}, {"Salami", 100}, {"Sausage", 100}, {"Steak", 100}, {"Tofu", 100}};
-- vendorsFoods[8] = {"Medical", {"AlcoholWipes", 40}, {"Antibiotics", 75}, {"PillsAntiDep", 75}, {"Bandage", 40}, {"PillsBeta", 40}, {"Disinfectant", 75}, {"Cigarettes", 40}, {"FirstAidKit", 100}, {"Pills", 75}, {"AlcoholBandage", 60}, {"PillsVitamins", 75}, {"Splint", 80}, {"SutureNeedle", 40}, {"SutureNeedleHolder", 40}, {"Tweezers", 40}};
vendorsFoods[8] = {"Medical", {"AlcoholWipes", 25}, {"Bandaid", 50}};

function VendISWorldObjectContextMenu.createMenu(player, context, worldobjects, test)
	vendorList = nil;
	vendMoney = 0;
	moneyContainer = {};
	local playerObj = getSpecificPlayer(player);
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj);
	for i=1, containers:size() do
		local container = containers:get(i-1);
		vendMoney = vendMoney + container:getAllType("Money"):size() + container:getAllType("OneDollar"):size() + container:getAllType("1Dollar"):size();
		vendMoney = vendMoney + (container:getAllType("2Dollar"):size()*2);
		vendMoney = vendMoney + (container:getAllType("5Dollar"):size()*5);
		vendMoney = vendMoney + ((container:getAllType("10Dollar"):size() + container:getAllType("TenDollar"):size())*10);
		vendMoney = vendMoney + (container:getAllType("20Dollar"):size()*20);
		vendMoney = vendMoney + ((container:getAllType("100Dollar"):size() + container:getAllType("HundredDollar"):size())*100);
		vendMoney = vendMoney + ((container:getAllType("1KDollar"):size() + container:getAllType("ThousandDollar"):size())*1000);
		vendMoney = vendMoney + (container:getAllType("2KDollar"):size()*2000);
		vendMoney = vendMoney + (container:getAllType("10KDollar"):size()*10000);
		vendMoney = vendMoney + (container:getAllType("20KDollar"):size()*20000);
		vendMoney = vendMoney + (container:getAllType("100KDollar"):size()*100000);
		if container:isInCharacterInventory(playerObj) then 
			table.insert(moneyContainer, container); 
			if container:getType() ~= "KeyRing" then
				moneyContainer.container = container; 
			end
		end
		if container:getType() == "floor" then
			for j=1,container:getItems():size() do
				local item = container:getItems():get(j-1);
				local dispCat = item:getDisplayCategory();
				if item:getType() then
					dispType = item:getType();
				end
				if dispCat == "Vendors" then
					if not vendorList then vendorList = {}; vendorList.vendors = {}; end
					if vendorList[dispType] then 
					else
						vendorList[dispType] = item;
						table.insert(vendorList.vendors, dispType);
					end
				end
			end
		end
	end
	if vendorList then VendorsMenus(playerObj, context, worldobjects, test); end
end

function VendorsMenus(playerObj, context, worldobjects, test)
	if VendorsConfig then
		if VendorsConfig.powerRequired then
			--print(VendorsConfig.powerRequired);
		end
	end
	-- reset values for inventory search.
	local moneyContainer = nil;
	vendorsJewelry.stones = {};
	vendorsJewelry.regular = {};
	vendorsJewelry.tags = {};
	vendorsJewelry.regular.items = {};
	vendorsJewelry.stones.items = {};
	vendorsJewelry.tags.items = {};
	vendorsJewelry.green = {};
	vendorsJewelry.green.items = {};
	vendorsSaleTotal = 0;
	local steamID = playerObj:getSteamID();
	local square = playerObj:getCurrentSquare();
	if not square then return end;
	--print(square:haveElectricity());
	
	
	local worldObj = worldobjects;
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj);
	local dispType = nil;
	vendorsSellables.custom = {};
	vendorsSellables.custom.items = {};


	if vendorList.ATMMachine then 
		for i=1,containers:size() do
			local container = containers:get(i-1);
			if container:isInCharacterInventory(playerObj) then
				for j=1,container:getItems():size() do
					local item = container:getItems():get(j-1);
					-- don't want to sell the fancy stuff you're wearing, or have attached
					if not playerObj:isEquipped(item) and not playerObj:isAttachedItem(item) then
						local dispCat = item:getDisplayCategory();
						if item:getType() then
							dispType = item:getType();
						end
						if item:isInPlayerInventory() then
							for i,v in pairs(vendorsSellables) do
								if v[1] == item:getType() then
									--if v[4] then
									--else
										table.insert(vendorsSellables.custom.items, {item, v[2], container, v[4]});
										if not vendorsSellables.custom[dispType] then vendorsSellables.custom[dispType] = {};
											vendorsSellables.custom[dispType].items = {item, v[2]};
											vendorsSellables.custom[dispType].count = 1;
											vendorsSellables.custom[dispType].menuCreated = false;
										else
											vendorsSellables.custom[dispType].count = vendorsSellables.custom[dispType].count + 1;
										end
										vendorsSaleTotal = vendorsSaleTotal + vendorsSellables.custom[dispType].items[2];							
									--end
								end
							end
							-- if string.find(dispType, "DogTag") then
							-- 	table.insert(vendorsJewelry.tags.items, {item, vendorsJewelry.prices.tags, container});
							-- 	if not vendorsJewelry.tags[dispType] then vendorsJewelry.tags[dispType] = {};
							-- 		vendorsJewelry.tags[dispType].items = {item, vendorsJewelry.prices.tags};
							-- 		vendorsJewelry.tags[dispType].count = 1;
							-- 		vendorsJewelry.tags[dispType].menuCreated = false;
							-- 	else 
							-- 		vendorsJewelry.tags[dispType].count = vendorsJewelry.tags[dispType].count + 1;
							-- 	end
							-- 	vendorsSaleTotal = vendorsSaleTotal + vendorsJewelry.tags[dispType].items[2];
							-- elseif (dispCat == "Accessory" or dispCat == "ClothM") and (string.find(dispType, "Diamond") or string.find(dispType, "Emerald") or string.find(dispType, "Amethyst") or string.find(dispType, "Ruby") or string.find(dispType, "Sapphire") or string.find(dispType, "Amber")) then
							-- 	table.insert(vendorsJewelry.stones.items, {item, vendorsJewelry.prices.stones, container})
							-- 	if not vendorsJewelry.stones[dispType] then vendorsJewelry.stones[dispType] = {};
							-- 		vendorsJewelry.stones[dispType].items = {item, vendorsJewelry.prices.stones};
							-- 		vendorsJewelry.stones[dispType].count = 1;
							-- 		vendorsJewelry.stones[dispType].menuCreated = false;
							-- 	else 
							-- 		vendorsJewelry.stones[dispType].count = vendorsJewelry.stones[dispType].count + 1;
							-- 	end
							-- 	vendorsSaleTotal = vendorsSaleTotal + vendorsJewelry.stones[dispType].items[2];
							-- elseif (not string.find(dispType, "Flame") and not string.find(dispType, "Key") and not string.find(dispType, "DogTag")) and ((dispCat == "Accessory" or dispCat == "ClothM" or dispCat == "ClothA") and ((string.find(dispType, "Ring") or string.find(dispType, "ring")) or string.find(dispType, "necklace") or string.find(dispType, "Necklace") or string.find(dispType, "Bracelet") or string.find(dispType, "Choker") or string.find(dispType, "Bangle") or string.find(dispType, "Locket") or string.find(dispType, "Watch") or (string.find(dispType, "Nose") and string.find(dispType, "Stud")) or string.find(dispType, "BellyButton"))) then															-- price for selling regular vendorsJewelry
							-- 	table.insert(vendorsJewelry.regular.items, {item, vendorsJewelry.prices.regular, container});
							-- 	if not vendorsJewelry.regular[dispType] then vendorsJewelry.regular[dispType] = {};
							-- 		vendorsJewelry.regular[dispType].items = {item, vendorsJewelry.prices.regular};
							-- 		vendorsJewelry.regular[dispType].count = 1;
							-- 		vendorsJewelry.regular[dispType].menuCreated = false;
							-- 	else
							-- 		vendorsJewelry.regular[dispType].count = vendorsJewelry.regular[dispType].count + 1;
							-- 	end
							-- 	vendorsSaleTotal = vendorsSaleTotal + vendorsJewelry.regular[dispType].items[2];
							-- end
							-- looking for GreenFireMod products  TODO Add more gfm items, add brita weapons
							-- if vendorsGreenFireMod then
							-- 	vendorsSaleTotal = vendorsSaleTotal + Vendors_GreenFireCheck(item, container, playerObj, vendorsSaleTotal);
							-- end
						end
					end	
				end
			end
		end
	end
	-- if there are vendors in the area then we call the function to display the menu
	if vendorList then
		table.sort(vendorList.vendors);
		Vendors_ContextMenu(playerObj, worldObj, context, vendorList, vendMoney);
	end
end

	-- display main context menu option
function Vendors_ContextMenu(player, worldobjects, context, list, money)
	local vendorList = list;
	local worldObj = worldobjects;
	local vendorOption = context:addOptionOnTop(getText("ContextMenu_Vendor_options"), worldObj);
	local vendorSubMenu = ISContextMenu:getNew(context);
	local subContext = context:addSubMenu(vendorOption, vendorSubMenu);
	Vendors_subContextMenu(subContext, vendorList, vendorSubMenu, context, player);
	local subVendorOption = vendorSubMenu:addOptionOnTop("� ��� ($" .. vendMoney .. ")", worldObj);
end	
	-- display sub context menus
function Vendors_subContextMenu(subContext, vendorList, vendorSubMenu, context, player)
	for i,v in ipairs(vendorList.vendors) do
		local vendorType = v
		local subVendorOption = {};
		subVendorOption = vendorSubMenu:addOption(getText("ContextMenu_" .. vendorType), worldObj);
		local subSubMenu = ISContextMenu:getNew(vendorSubMenu);
		local subSubContext = context:addSubMenu(subVendorOption, subSubMenu);
		Vendors_subSubContextMenu(subSubContext, vendorList, subSubMenu, context, player, vendorType, worldobjects)
	end
end
	-- display subsub and subsubsub context menus
function Vendors_subSubContextMenu(subSubContext, vendorList, subSubMenu, context, player, vendorType, worldobjects)
	local playerObj = getSpecificPlayer(0);
	local playerInv = playerObj:getInventory();
	-- searching for vendor type to display correct context menus
	if vendorType == "ATMMachine" then
		-- looking for jewelry items that were found during the inventory search in the initial function
		if #vendorsJewelry.tags.items == 0 and #vendorsJewelry.stones.items == 0 and #vendorsJewelry.regular.items == 0 and #vendorsJewelry.green.items == 0 and #vendorsSellables.custom.items == 0 then
			local subSubVendorOption = subSubMenu:addOptionOnTop(getText("ContextMenu_Nothing_To_Sell"), worldobjects);
		else
			local subSubVendorOption = subSubMenu:addOption(getText("ContextMenu_Sell_All") .. " ($" .. vendorsSaleTotal .. ")", worldobjects, Buy_VendorsItem, player, vendorsJewelry, true, 0, true);
			if #vendorsSellables.custom.items > 0 then
				Vendors_DisplayJewelryOptions(subSubMenu, context, player, vendorsSellables.custom)
			end
			if #vendorsJewelry.tags.items > 0 then
				Vendors_DisplayJewelryOptions(subSubMenu, context, player, vendorsJewelry.tags)
			end
			if #vendorsJewelry.stones.items > 0 then
				Vendors_DisplayJewelryOptions(subSubMenu, context, player, vendorsJewelry.stones)
			end
			if #vendorsJewelry.regular.items > 0 then
				Vendors_DisplayJewelryOptions(subSubMenu, context, player, vendorsJewelry.regular)
			end
			if #vendorsJewelry.green.items > 0 then
				Vendors_DisplayJewelryOptions(subSubMenu, context, player, vendorsJewelry.green)
			end
		end
	end
	-- food, were building menus to buy food
	if vendorType == "FoodVendor" then
		Vendors_DisplayFoodOptions(subSubMenu, context, player, vendorsFoods);		
	end
	-- tools.  for to buy
	if vendorType == "ToolVendor" then
		Vendors_DisplayToolOptions(subSubMenu, context, player, vendorsTools, worldobjects)
	end
	if vendorType == "VehicleVendor" then
		-- creating a menu item for engine parts, to be listed in the first vehicle submenu above the other submenu options
		local part = {"EngineParts", vendorsVehicles.engineParts[1]};
		local partName = "EngineParts";
		-- im not sure how to get the item name in order to avoid adding translations for everything unless i add it to your inventory.  so everything on the list, everything(minus what you're selling), is added and then removed from your inventory...  sorry, if anyone has a method to get the actual item object without having it in your inventory, i could use your help...
		local partItem = playerInv:AddItem(partName);
		local partItemType = partItem:getType();
		local partItemName = partItem:getName();
		local partItemQuant = vendorsVehicles.engineParts[2]
		local partItemPrice = vendorsVehicles.engineParts[1]
		playerInv:Remove(partItem);
		local vehicle = player:getNearVehicle();
		if vehicle then
			local subSubVendorOption = subSubMenu:addOption(getText("IGUI_VehicleName" .. vehicle:getScript():getName()) .. " key - $5000", playerObj, Buy_VendorsVehicleKey, vehicle);
		end
		local subSubVendorOption = subSubMenu:addOption(partItemQuant .. " " .. partItemName .. " ($" .. partItemPrice .. ")", worldobjects, Buy_VendorsItem, player, part, false, partItemPrice, false, 30);
		for i,v in pairs(vendorsVehicles.parts) do
			local subTable = v;
			local vehicleOption = subSubMenu:addOption(getText("ContextMenu_" .. subTable[1] .. "_Type_Car_Parts"), worldobjects);
			local subSubMenu = ISContextMenu:getNew(subSubMenu);
			local subContext = context:addSubMenu(vehicleOption, subSubMenu);
			for h, w in pairs(subTable) do
				if h > 1 then
					local part = w;
					local partName = w[1];
					local partPrice = w[2];
					local partItem = playerInv:AddItem(partName);
					local partItemType = partItem:getType();
					local partItemName = partItem:getName();
					playerInv:Remove(partItem);
					local subSubVendorOption = subSubMenu:addOption(partItemName .. " ($" .. partPrice .. ")", worldobjects, Buy_VendorsItem, player, part, false, partPrice, false);					
				end
			end 
		end
		local vehicleOption = subSubMenu:addOption(getText("ContextMenu_Vehicles"), worldobjects);
		local subSubMenu = ISContextMenu:getNew(subSubMenu);
		local subContext = context:addSubMenu(vehicleOption, subSubMenu);
		for i,v in pairs(vendorsVehicles.vehicles) do
			for j,k in pairs(v) do
				local subTable = v[j];
				if j > 1 then
					local vendorsRand = ZombRand(1, #subTable[1]+1)
					local vehicle = subTable[1][vendorsRand];
					local vehiclePrice = subTable[2];
					local vendorsVehicleName = subTable[1][1];
					if vendorsVehicleName == "TrailerAdvert" then vendorsVehicleName = "Advertising_Trailer"; end
					local vehicleOption = subSubMenu:addOption(getText("IGUI_VehicleName" .. vendorsVehicleName) .. " ($" .. vehiclePrice .. ") ", worldobjects, Buy_VendorsVehicle, vehicle, vehiclePrice, player);
				end
			end
		end
	end
	if vendorType == "WeaponVendor" then
		for i,v in pairs(vendorsWeapons) do
			local subTable = v;
			if subTable[1][1] == "Custom" then
				local magazineOption = subSubMenu:addOption(getText("ContextMenu_" .. subTable[1][2]), worldobjects);
				local subSubMenu = ISContextMenu:getNew(subSubMenu);
				local subContext = context:addSubMenu(magazineOption, subSubMenu);
			end
			if subTable[1] == "Caliber" then
				local magazineOption = subSubMenu:addOption(getText("ContextMenu_Magazines"), worldobjects);
				local subSubMenu = ISContextMenu:getNew(subSubMenu);
				local subContext = context:addSubMenu(magazineOption, subSubMenu);
				for h,w in pairs(subTable) do
					local caliber = w;
					if caliber ~= "Caliber" then
						local caliberOption = subSubMenu:addOption(caliber, worldobjects);
						local subSubMenu = ISContextMenu:getNew(subSubMenu);
						local subContext = context:addSubMenu(caliberOption, subSubMenu);
						for n,o in pairs(vendorsWeapons[2]) do
							local magazineCaliber = o[4];
							if magazineCaliber == caliber then
								local magazine = o;
								local magazineName = magazine[1];
								-- price is table of x,x,x,x, value is integer.  price is used to distribute denominations, value for displaying cost inside the menu and for comparing against the wallet
								local magazinePrice = magazine[2];
								local magazineItem = magazine[1];
								local addedItem = playerInv:AddItem(magazineItem);
								local magazineItemType = addedItem:getType();
								local magazineItemName = addedItem:getDisplayName();
								if magazineName == "M14Clip" then magazineItemName = ".308 Magazine(M14)"; end
								playerInv:Remove(addedItem);
								local subSubVendorOption = subSubMenu:addOption(magazineItemName .. " ($" .. magazinePrice .. ") ", worldobjects, Buy_VendorsItem, player, magazine, false, magazinePrice, false);
							end
						end
					end
				end
			elseif subTable[1] == "Slots" then
				Vendors_DisplayAttachmentSlots(subSubMenu, subTable, context, player);
			elseif subTable[1] ~= "Magazines"  and subTable[1] ~= "Attachments" then
				local weaponOptions = subTable[1];
				local weaponOption = subSubMenu:addOption(getText("ContextMenu_" .. weaponOptions), worldobjects);
				local subSubMenu = ISContextMenu:getNew(subSubMenu);
				local subContext = context:addSubMenu(weaponOption, subSubMenu);
				for l,m in pairs(v) do
					if l > 1 then
						local weapon = m;
						local weaponName = weapon[1];
						-- price is table of x,x,x,x, value is integer.  price is used to distribute denominations, value for displaying cost inside the menu and for comparing against the wallet
						local weaponPrice = weapon[2];
						local multipleBuy = weapon[3];
						local weaponItem = playerInv:AddItem(weaponName);
						local weaponItemType = weaponItem:getType();
						local weaponItemIsWeapon = weaponItem:IsWeapon();
						local weaponItemName = weaponItem:getName();
						local weaponItemCategory = weaponItem:getDisplayCategory();
						if weaponItemCategory == "Ammo" then
							if not string.find(weaponItem:getType(), "Box") then
								if string.find(weaponItem:getType(), "Bullets") then
									for i=1, 4 do
										playerInv:Remove(weaponItemType);
									end
								elseif string.find(weaponItem:getType(), "Shells") then
									for i=1, 5 do
										playerInv:Remove(weaponItemType);
									end
								end
							end
						end
						playerInv:Remove(weaponItem);
						if weapon[3] == "" then
							local subSubVendorOption = subSubMenu:addOption(weaponItemName .. " ($" .. weaponPrice .. ") ", worldobjects, Buy_VendorsItem, player, weapon, false, weaponPrice, false);
						elseif weaponItemIsWeapon then
							local weaponItemAmmoType = weapon[4];
							local subSubVendorOption = subSubMenu:addOption(weaponItemName .. " (" .. weaponItemAmmoType .. ")  ($" .. weaponPrice .. ") ", worldobjects, Buy_VendorsItem, player, weapon, false, weaponPrice, false);
						elseif multipleBuy == true then
							local ammoBoxOption = subSubMenu:addOption(weaponItemName, worldobjects);
							local subSubMenu = ISContextMenu:getNew(subSubMenu);
							local subContext = context:addSubMenu(ammoBoxOption, subSubMenu);
							local subSubVendorOption = subSubMenu:addOption(weaponItemName .. " 1 for ($" .. weaponPrice .. ") ", worldobjects, Buy_VendorsItem, player, weapon, false, weaponPrice, false);
							weaponPrice10 = weaponPrice*10;
							local subSubVendorOption = subSubMenu:addOption(weaponItemName .. " 10 for ($" .. weaponPrice10 .. ") ", worldobjects, Buy_VendorsItem, player, weapon, false, weaponPrice10, false, 10);	
							weaponPrice25 = weaponPrice*25
							local subSubVendorOption = subSubMenu:addOption(weaponItemName .. " 25 for ($" .. weaponPrice25 .. ") ", worldobjects, Buy_VendorsItem, player, weapon, false, weaponPrice25, false, 25);				
						else
							local subSubVendorOption = subSubMenu:addOption(weaponItemName .. " ($" .. weaponPrice .. ") ", worldobjects, Buy_VendorsItem, player, weapon, false, weaponPrice, false);
						end
					end
				end
			end
		end
	end
end


function Vendors:sendClientCommand(playerObj, mType, command, args)
	return sendClientCommand(playerObj, mType, command, args);
end

function Buy_VendorsVehicle(worldObjects, vehicle, moneyInteger)
	local playerObj = getSpecificPlayer(0);
	if vendMoney >= moneyInteger then
		if isClient() then
			Vendors:sendClientCommand(playerObj, "Vendors", "spawnVehicle", {fullId = vehicle, withKey = true, direction = S,}); ---TODO change to vehicleFULLNAME
		else
			local car = Vendors_AddVehicle(vehicle, playerObj);
			sendClientCommand(playerObj, "vehicle", "getKey", {vehicle = car:getId()});
			sendClientCommand(playerObj, "vehicle", "repair", {vehicle = car:getId()});
		end
		Vendors_CalculateChange(moneyInteger, playerObj);	
	else
		playerObj:Say(getText("ContextMenu_Cant_Buy"));
	end
end

-- yeah, it says buy but we sell items here too.  I thought i was going to need a seperate function at first, turns out i could get it all with one!  woot!
-- item is a table containing the item we're buying or selling.  sell is boolean, as well as sellAll.  moneyQuantity is a table, quantity is an integer.  quantity is used for only the dry fan leaves at the moment(also for buying engine parts now), sell 100 for $10.
function Buy_VendorsItem(worldobjects, player, item, sell, moneyQuantity, sellAll, quantity, sellAllOfItem)
	local playerObj = player;
	local playerInv = playerObj:getInventory();
	local itemTable = item;
	local moneyInteger = itemTable[2];
	local sellAllTotal = 0;
	-- if were selling all the loot, then were searching through all the tables.  the tables of items that we're going to sell, not the ones filled with stuff we might buy.
	if sellAll then
		if #vendorsSellables.custom.items > 0 then
			for i,v in ipairs(vendorsSellables.custom.items) do
				local jewelryItem = v[1];
				local moneyInteger = v[2];
				Vendors_RemoveItem(jewelryItem, v[3]);
				sellAllTotal = sellAllTotal + v[2];
			end
		end
		if #vendorsJewelry.tags.items > 0 then
			for i,v in ipairs(vendorsJewelry.tags.items) do
				local jewelryItem = v[1];
				local moneyInteger = v[2];
				Vendors_RemoveItem(jewelryItem, v[3]);
				sellAllTotal = sellAllTotal + v[2];
			end
		end
		-- another bag of loot to sift through
		if #vendorsJewelry.stones.items > 0 then
			for i,v in pairs(vendorsJewelry.stones.items) do
				local jewelryItem = v[1];
				Vendors_RemoveItem(jewelryItem, v[3])
				sellAllTotal = sellAllTotal + v[2];
			end
		end
		-- and another one gone, and another one gone
		if #vendorsJewelry.regular.items > 0 then
			for i,v in pairs(vendorsJewelry.regular.items) do
				local jewelryItem = v[1];
				local moneyInteger = v[2];
				Vendors_RemoveItem(jewelryItem, v[3]);
				sellAllTotal = sellAllTotal + v[2];
			end
		end
		-- last one for sell all!
		if #vendorsJewelry.green.items > 0 then
			for i,v in pairs(vendorsJewelry.green.items) do
				local item = v;
				local jewelryItem = item[1];
				local moneyInteger = item[2];
				local dispType = item[1]:getType();
				local quantity = vendorsJewelry.green[dispType].count
				if item[4] ~= nil and item[4] > 1 then
					moneyInteger = item[2];
					local itemQuantity = item[4]*quantity;
					jewelryItemName = item[1]:getName();
					jewelryItemType = item[1]:getType();
					local containers = ISInventoryPaneContextMenu.getContainers(playerObj);
					local itemListOfSellables = {};
					for i=1,containers:size()-1 do
						local container = containers:get(i-1);
						for j=1,container:getItems():size() do
							local item = container:getItems():get(j-1);
							if item:getType() == jewelryItemType and item:isInPlayerInventory() then
								table.insert(itemListOfSellables, {item, container});
								itemQuantity = itemQuantity-1;
								if itemQuantity == 0 then break end
							end
						end
					end
					for i,v in pairs(itemListOfSellables) do
						Vendors_RemoveItem(v[1], v[2]);
					end
				else
					Vendors_RemoveItem(v[1], v[3]);
					moneyInteger = item[2]
				end
				sellAllTotal = sellAllTotal + moneyInteger;
			end
		end
		
		Vendors_CalculateChange(sellAllTotal*-1, player);
	-- now to sell individual items
	elseif sell and not sellAll then
		if quantity then
			-- alright, we're not just selling individual items, we're selling bulk of item types as well...
			if sellAllOfItem then
				if item[4] ~= nil and item[4] > 1 then
					moneyInteger = item[3]*item[5]/item[4];
					local itemQuantity = item[1][1][4]*quantity;
					jewelryItemName = item[1][1][1]:getName();
					jewelryItemType = item[1][1][1]:getType();
					local containers = ISInventoryPaneContextMenu.getContainers(playerObj);
					local itemListOfSellables = {};
					for i=1,containers:size()-1 do
						local container = containers:get(i-1);
						for j=1,container:getItems():size() do
							local item = container:getItems():get(j-1);
							if item:getType() == jewelryItemType and item:isInPlayerInventory() then
								table.insert(itemListOfSellables, {item, container});
								itemQuantity = itemQuantity-1;
								if itemQuantity == 0 then break end
							end
						end
					end
					for i,v in pairs(itemListOfSellables) do
						Vendors_RemoveItem(v[1], v[2]);
					end
				else
					local jewelryItem = itemTable[1];
					for i,v in pairs(jewelryItem) do
						if v[1]:getType() == item[2] then
							Vendors_RemoveItem(v[1], v[3]);
						end
					end
					moneyInteger = item[3]*quantity;
				end
			else
				local jewelryItem = item[1];
				jewelryItemName = jewelryItem:getName();
				jewelryItemType = jewelryItem:getType();
				local containers = ISInventoryPaneContextMenu.getContainers(playerObj);
				local itemListOfSellables = {};
				for i=1,containers:size()-1 do
					local container = containers:get(i-1);
					for j=1,container:getItems():size() do
						local item = container:getItems():get(j-1);
						if item:getType() == jewelryItemType and item:isInPlayerInventory() then
							table.insert(itemListOfSellables, {item, container});
							quantity = quantity-1;
							if quantity == 0 then break end
						end
					end
				end
				for i,v in pairs(itemListOfSellables) do
					Vendors_RemoveItem(v[1], v[2]);
				end
			end
		else
			local jewelryItem = item[1];
			Vendors_RemoveItem(jewelryItem, item[3]);
		end
		-- give me that money!
		Vendors_CalculateChange(moneyInteger*-1, player);
		-- not selling and not selling all, we're buying.  at this moment though its all free, i still need to fix how it removes the cash.  i was wrong, it's actually all broken at the moment, cant buy anything right now.   fixed part of it, you can now receive free items as long as you have enough to cover it, but it won't take your money.  i fixed that, it will now take your money but it will also give you more than 400x your change back.  progress...  that didn't take long, giving correct change now.  fuck me, it's broken again...
	elseif not sell and not sellAll then
		if vendMoney >= moneyInteger then
			if quantity then
				for i=1,quantity-1 do
					local addedItem = Vendors_AddItem(item[1], playerInv);
				end
			end
			local addedItem = Vendors_AddItem(item[1], playerInv);
			Vendors_CalculateChange(moneyInteger, player);
		else
			playerObj:Say(getText("ContextMenu_Cant_Buy"));
		end
	end
end

function Vendors_RemoveItem(item, container)
	container:DoRemoveItem(item);
	container:Remove(item);
end

function Buy_VendorsVehicleKey(player, vehicle)
	if vendMoney >= 5000 then
		Vendors_CalculateChange(5000, player);
		sendClientCommand(player, "vehicle", "getKey", { vehicle = vehicle:getId() });
	else
		player:Say(getText("ContextMenu_Cant_Buy"));
	end
end

function Vendors_CalulatePrice(moneyInteger)
	-- clean this up if you dont need floor  i do need floor but i cleaned it up anyways
	vendCash[1] = {math.floor((moneyInteger)/1000), "Vendors.ThousandDollar", true};
	vendCash[2] = {(math.floor((moneyInteger)/100) - (math.floor(moneyInteger/1000)*10)), "Vendors.HundredDollar"};
	vendCash[3] = {(math.floor((moneyInteger)/10) - (math.floor(moneyInteger/100)*10)), "Vendors.TenDollar"};
	vendCash[4] = {(math.floor((moneyInteger)) - (math.floor(moneyInteger/10)*10)), "Vendors.OneDollar"};
	return vendCash;
end

function Vendors_CalculateChange(moneyInteger, player)
	local playerInv = player:getInventory();
	if moneyContainer.container == nil then moneyContainer.container = playerInv; end
	local vendCashToGive = vendMoney - moneyInteger;
	print(vendCashToGive, " - to give");
	local vendCash = {}
	vendCash[1] = {math.floor((vendCashToGive)/1000), "Vendors.ThousandDollar", true};
	vendCash[2] = {(math.floor((vendCashToGive)/100) - (math.floor(vendCashToGive/1000)*10)), "Vendors.HundredDollar"};
	vendCash[3] = {(math.floor((vendCashToGive)/10) - (math.floor(vendCashToGive/100)*10)), "Vendors.TenDollar"};
	vendCash[4] = {(math.floor((vendCashToGive)) - (math.floor(vendCashToGive/10)*10)), "Vendors.OneDollar"};
	for i,v in pairs(moneyContainer) do
		local container = v;
		for i,v in pairs(moneyTypes) do
			container:RemoveAll(v);
		end
	end
	for i,v in pairs(vendCash) do
		for j=1, v[1] do
		Vendors_AddItem(v[2], moneyContainer.container);
		end
	end
	vendMoney = 0;
end

function Vendors_DisplayFoodOptions(subSubMenu, context, player, vendorsList)
	local playerInv = player:getInventory();
	for i,v in pairs(vendorsList) do
		local foodTable = v;
		local foodOption = subSubMenu:addOption(getText("ContextMenu_" .. foodTable[1]), worldobjects);
		local subSubMenu = ISContextMenu:getNew(subSubMenu);
		local subContext = context:addSubMenu(foodOption, subSubMenu);
		for j,k in pairs(foodTable) do
			local foodItemTable = k;
			if j ~= 1 then
				local foodItemType = foodItemTable[1];
				local foodItemPrice = foodItemTable[2];
				local foodItem = playerInv:AddItem(foodItemType);
				if foodItem:isCookable() and not string.find(foodItemType, "Dead") then foodItem:setCooked(true); end
				foodItemName = foodItem:getName();
				playerInv:Remove(foodItem);
				if foodItem:getType() == "Cigarettes" then
					for i=1, 19 do
						playerInv:Remove(foodItemType);
					end
				end
				local SubVendorOption = subSubMenu:addOption(foodItemName .. " ($" .. foodItemPrice .. ")", worldobjects, Buy_VendorsItem, player, foodItemTable, false, foodItemPrice);
			end
		end
	end
end

function Vendors_DisplayToolOptions(subSubMenu, context, player, vendorsList, worldobjects)
	local playerInv = player:getInventory();
	if vendorsBooks[1] ~= 0 then
		local toolOption = subSubMenu:addOption(getText("ContextMenu_Books"), worldobjects)
		local subMenu = ISContextMenu:getNew(subSubMenu);
		Vendors_ListBooks(subMenu, worldobjects, vendorsBooks, context, player);
		local subContext = context:addSubMenu(toolOption, subMenu);
	end
	for i,v in pairs(vendorsList) do
		local toolTable = v;
		local toolOption = subSubMenu:addOption(getText("ContextMenu_" .. toolTable[1]), worldobjects)
		local subSubMenu = ISContextMenu:getNew(subSubMenu);
		local subContext = context:addSubMenu(toolOption, subSubMenu);
		for j,k in pairs(toolTable) do
		local toolItemTable = k;
		if j ~= 1 then
			local toolItemType = toolItemTable[1];
			local toolItemPrice = toolItemTable[2];
			local toolItemQuantity = toolItemTable[3];
			local toolItem = playerInv:AddItem(toolItemType);
			toolItemName = toolItem:getName();
			playerInv:Remove(toolItem);
			if toolItemQuantity then toolItemPrice = toolItemPrice .. ") for (" .. toolItemQuantity; end
				local SubVendorOption = subSubMenu:addOption(toolItemName .. " ($" .. toolItemPrice .. ")", worldobjects, Buy_VendorsItem, player, toolItemTable, false, toolItemPrice, false);
			end
		end
	end
end

function Vendors_ListBooks(subSubMenu, worldobjects, vendorsList, context, player)
	local playerInv = player:getInventory();
	for i,v in pairs(vendorsBooks) do
		local toolOption = subSubMenu:addOption(getText("ContextMenu_" .. vendorsList[i][1]), worldobjects)
		local subSubMenu = ISContextMenu:getNew(subSubMenu);
		local subContext = context:addSubMenu(toolOption, subSubMenu);
		for j=2, #vendorsList[i] do
			local addedItem = playerInv:AddItem(vendorsList[i][j][1]);
			local addedItemType = addedItem:getType();
			local addedItemName = addedItem:getName();
			playerInv:Remove(addedItem);
			local toolOption = subSubMenu:addOption(addedItemName .. " ($" .. vendorsList[i][j][2] .. ")", worldobjects, Buy_VendorsItem, player, vendorsList[i][j], false, vendorsList[i][j][2]);
		end
	end
end

function Vendors_DisplayJewelryOptions(subSubMenu, context, player, jewelryList)
	local jewelryItemPrice = 0;
	local jewelryTable = jewelryList.items;
	local jewelryTableList = jewelryList;
	for i,v in pairs(jewelryTable) do
		local jewelryItemTable = v;
		local jewelryItemName = jewelryItemTable[1]:getName();
		local jewelryItemPrice = jewelryItemTable[2];
		local jewelryItemType = jewelryItemTable[1]:getType();
		local jewelryQuantity = jewelryItemTable[4];
		if jewelryQuantity == 1 then jewelryQuantity = nil; end
		if jewelryQuantity then 
			jewelryDispPrice = jewelryItemPrice .. " " .. getText("ContextMenu_for") .. " " .. jewelryQuantity;
		else
			jewelryQuantity = 1;
			jewelryDispPrice = jewelryItemPrice;
		end
		if jewelryTableList[jewelryItemType].count > 1 and not jewelryTableList[jewelryItemType].menuCreated then
			local jewelryItemOption = subSubMenu:addOption(jewelryItemName .. " ($" .. jewelryDispPrice .. ")", worldobjects);
			local subMenu = ISContextMenu:getNew(subSubMenu);
			local subContext = context:addSubMenu(jewelryItemOption, subMenu);
			local subVendorOption = subMenu:addOption(jewelryItemName .. " ($" .. jewelryDispPrice .. ")", worldobjects, Buy_VendorsItem, player, jewelryItemTable, true, jewelryItemPrice, false, jewelryQuantity);
			local subVendorOption = subMenu:addOption(jewelryItemName .. " - " .. getText("ContextMenu_Sell_all_for") ..  " ($" .. jewelryItemPrice*jewelryTableList[jewelryItemType].count/jewelryQuantity .. ")", worldobjects, Buy_VendorsItem, player, {jewelryList.items, jewelryItemType, jewelryItemPrice, jewelryQuantity, jewelryTableList[jewelryItemType].count}, true, jewelryItemPrice, false, jewelryTableList[jewelryItemType].count, true);
			jewelryTableList[jewelryItemType].menuCreated = true;
		elseif jewelryTableList[jewelryItemType].count == 1 then
			local subSubVendorOption = subSubMenu:addOption(jewelryItemName .. " ($" .. jewelryItemPrice .. ")", worldobjects, Buy_VendorsItem, player, jewelryItemTable, true, jewelryItemPrice, false, jewelryQuantity);
		end
	end
end

function Vendors_DisplayAttachmentSlots(subSubMenu, subTable, context, player)
	local playerInv = player:getInventory();
	local slotOption = subSubMenu:addOptionOnTop(getText("ContextMenu_Attachments"), worldobjects);
	local subSubMenu = ISContextMenu:getNew(subSubMenu);
	local subContext = context:addSubMenu(slotOption, subSubMenu);
	for h,w in pairs(subTable) do
		local slotOptions = w;
		if slotOptions ~= "Slots" then
			local attachmentOption = subSubMenu:addOption(getText("ContextMenu_" .. slotOptions), worldobjects);
			local subSubMenu = ISContextMenu:getNew(subSubMenu);
			local subContext = context:addSubMenu(attachmentOption, subSubMenu);
			for n,o in pairs(vendorsWeapons[3]) do
				local slot = o[4];
				if slot == slotOptions then
					local attachment = o;
					local attachmentName = attachment[1];
					-- price is table of x,x,x,x, value is integer.  price is used to distribute denominations, value for displaying cost inside the menu and for comparing against the wallet
					local attachmentPrice = attachment[2];
					local attachmentItem = playerInv:AddItem(attachmentName);
					local attachmentItemType = attachmentItem:getType();
					local attachmentItemName = attachmentItem:getName();
					playerInv:Remove(attachmentItem);
					local subSubVendorOption = subSubMenu:addOption(attachmentItemName .. " ($" .. attachmentPrice .. ")", worldobjects, Buy_VendorsItem, player, attachment, false, attachmentPrice, false);
				end
			end
		end
	end
end

function Vendors_CheckMods()
	vendorsBritaMod = getActivatedMods():contains("Brita");
	vendorsBrita_2Mod = getActivatedMods():contains("Brita_2");
	vendorsGreenFireMod = getActivatedMods():contains("jiggasGreenfireMod");
	vendorsFilibusterMod = getActivatedMods():contains("FRUsedCars");
	BMSVendorMod = getActivatedMods():contains("BetterMoneySystem");
	if vendorsBritaMod then
		-- Brita weapons ------------------------------------
		vendorsWeapons[1] = {"Box_Ammo", {"ShotgunShellsBox", 150, true}, {"40HERound", 10000, true}, {"40INCRound",  12000, true}, {"Bullets22Box", 100, true}, {"223Box", 150, true}, {"3006Box", 100, true}, {"308Box", 150, true}, {"Bullets357Box", 150, true}, {"Bullets38Box", 100, true}, {"Bullets380Box", 150, true}, {"Bullets44Box", 150, true}, {"Bullets4570Box", 200, true}, {"Bullets45Box", 100, true}, {"Bullets45LCBox", 100, true}, {"545x39Box", 200, true}, {"556Box", 250, true}, {"Bullets57Box", 200, true}, {"Bullets50MAGBox", 350, true}, {"50BMGBox", 350, true}, {"762x39Box", 250, true}, {"762x51Box", 250, true}, {"762x54rBox", 250, true}, {"Bullets9mmBox", 100, true}};
		vendorsWeapons[2] = {"Magazines", {"12gDrum", 1750, false, "12g"}, {"SPASClip", 300, false, "12g"}, {"SIX12_Cylinder", 2500, false, "12g"}, {"22Drum", 1750, false, ".22-LR"}, {"22ExtClip", 300, false, ".22-LR"}, {"22Clip", 300, false, ".22-LR"}, {"223Clip", 300, false, ".223-REM"}, {"223ExtClip", 300, false, ".223"}, {"1903Clip", 300, false, "30-06 SPRG"}, {"3006ExtClip", 300, false, "30-06 SPRG"}, {"308Belt", 1750, false, ".308"}, {"308MiniCan", 300, false, ".308"}, {"308StdClip", 300, false, ".308"}, {"308ExtClip", 300, false, ".308"}, {"357Speed", 300, false, ".357-MAG"}, {"38Clip", 300, false, ".38-SPC"}, {"38Speed", 300, false, ".38-SPC"}, {"380ExtClip", 300, false, ".380-ACP"}, {"380Clip", 300, false, ".380-ACP"}, {"44Clip", 250, false, ".44-MAG"}, {"44Speed", 300, false, ".44-MAG"}, {"45Clip", 250, false, ".45-ACP"}, {"45ExtClip", 300, false, ".45-ACP"}, {"45DSClip", 300, false, ".45-ACP"}, {"45DSExtClip", 300, false, ".45-ACP"}, {"45Drum", 1750, false, ".45-ACP"}, {"45LCSpeed", 300, false, ".45-LC"}, {"50MiniCan", 300, false, ".50 BMG"}, {"M82Clip", 350, false, ".50 BMG"}, {"545Drum", 1750, false, "5.45"}, {"545StdClip", 300, false, "5.45"}, {"556Belt", 1750, false, "5.56"}, {"556Drum", 1750, false, "5.56"}, {"556Clip", 350, false, "5.56"}, {"556MiniCan", 350, false, "5.56"}, {"57Clip", 350, false, "5.7x28"}, {"P90Clip", 350, false, "5.7x28"}, {"M14Clip", 300, false, ".308"}, {"762x39Belt", 1750, false, "7.62x39"}, {"762Drum", 1750, false, "7.62x39"}, {"AKClip", 350, false, "7.62x39"}, {"SKSClip", 350, false, "7.62x39"}, {"762x54rBelt", 1750, false, "7.62x54"}, {"SVDClip", 350, false, "7.62x54"}, {"MosinClip", 350, false, "7.62x54"}, {"9mmClip", 300, false, "9mm"}, {"9mmExtClip", 300, false, "9mm"}, {"9mmDrum", 1750, false, "9mm"}, {"ASHClip", 300, false, ".50 MAG"}};
		vendorsWeapons[3] = {"Attachments", {"Sight_3xEOTech", 350, false, "Sight"}, {"Sight_4xACOG", 350, false, "Sight"}, {"Sight_Aimpoint_Dot", 350, false, "Sight"}, {"Sight_Thermal", 350, false, "Sight"}, {"Laser_PEQ15", 350, false, "Side"}, {"Choke_Full", 200, false, "Barrel"}, {"ChokeTubeImproved", 200, false, "Barrel"}, {"FiberglassStock", 150, false, "Stock"}, {"Sight_Malcom", 450, false, "Sight"}, {"IronSight", 100, false, "Sight"}, {"Laser", 200, false, "Side"}, {"Light_Large", 200, false, "Side"}, {"Light_Small", 100, false, "Side"}, {"Sight_VX3", 450, false, "Sight"}, {"RecoilPad", 100, false, "Stock"}, {"Pad", 100, false, "Stock"}, {"RedDot", 200, false, "Sight"}, {"Sight_G28_Scope", 450, false, "Sight"}, {"Sling_1", 150, false, "Bottom"}, {"Sling_2", 150, false, "Bottom"}, {"Sling_3", 150, false, "Bottom"}, {"Launcher", 1250, false, "Bottom"}, {"Suppressor_BMG", 500, false, "Barrel"}, {"Suppressor_ROME_BMG", 550, false, "Barrel"}, {"Suppressor_Pistol", 400, false, "Barrel"}, {"Suppressor_SOCOM_Pistol", 450, false, "Barrel"}, {"Suppressor_Shotgun", 450, false, "Barrel"}, {"Suppressor_Rifle", 450, false, "Barrel"}, {"Suppressor_PBS1_Rifle", 550, false, "Barrel"}, {"x2Scope", 300, false, "Sight"}, {"x4Scope", 350, false, "Sight"}, {"x8Scope", 400, false, "Sight"}};
		vendorsWeapons[4] = {"Caliber", "12g", ".22-LR", ".223-REM", "30-06 SPRG", ".308", ".357-MAG", ".38-SPC", ".380-ACP", ".44-MAG", ".45-ACP", ".45-LC", "5.45", "5.56", "5.7x28", ".50 MAG", ".50 BMG", "7.62x39", "7.62x54", "9mm"};
		vendorsWeapons[5] = {"Pistols", {"Automag", 3500, false, ".44-MAG"}, {"B93R", 3000, false, "9mm"}, {"M9", 3000, false, "9mm"}, {"M9A3", 3000, false, "9mm"}, {"CZ75", 3000, false, "9mm"}, {"G17", 3000, false, "9mm"}, {"G18", 3000, false, "9mm"}, {"G21", 3000, false, ".45-ACP"}, {"G42", 3000, false, ".380-ACP"}, {"HK_USP", 3500, false, ".45-ACP"}, {"Pistol3", 3000, false, ".44-MAG"}, {"Pistol2", 3000, false, ".45 Auto"}, {"Revolver_Long", 2000, false, ".44-MAG"}, {"Revolver", 2000, false, ".45 Auto"}, {"Revolver_Short", 1500, false, ".38-SPC"}, {"M4506", 3000, false, ".45-ACP"}, {"M5238", 3000, false, ".38-SPC"}, {"M5906", 3000, false, "9mm"}, {"Pistol", 2500, false, "9mm"}};
		vendorsWeapons[6] = {"Shotguns", {"DAO12", 2500, false, "12g"}, {"AA12", 4500, false, "12g"}, {"DT11", 2500, false, "12g"}, {"CAWS", 4500, false, "12g"}, {"DoubleBarrelShotgun", 750, false, "12g"}, {"Shotgun", 2500, false, "12g"}, {"SIX12SD", 6500, false, "12g"}};
		vendorsWeapons[7] = {"Rifles", {"AK103", 7500, false, "7.62x39"}, {"AK12_New", 7500, false, "5.45"}, {"AK47", 7500, false, "7.62x39"}, {"AK74", 7500, false, "5.45"}, {"AKM", 7500, false, "7.62x39"}, {"M4A1", 8500, false, "5.56"}, {"DR_200", 7500, false, "5.56"}, {"K2_1", 7500, false, "5.56"}, {"SVDK",  10000, false, "7.62x54"}, {"EDM96",  12000, false, ".50 BMG"}, {"Gepard_M6",  12000, false, ".50 BMG"}, {"G11K3", 7500, false, "5.7x28"}, {"G36KV", 7500, false, "5.56"}, {"HuntingRifle", 4500, false, ".308"}, {"AssaultRifle2", 7500, false, ".308"}, {"AssaultRifle",  10000, false, "5.56"}, {"M40A1", 7500, false, ".308"}, {"M40A3", 7500, false, ".308"}, {"VarmintRifle", 3500, false, ".223-REM"}};
		vendorsWeapons[9] = {"SMGs", {"CAR15SMG", 6000, false, "5.56"}, {"K1_1", 6000, false, "5.56"}, {"K7_Stock", 6000, false, "9mm"}};
		vendorsWeapons[10] = {"LMGs", {"K3LMG",  12000, false, "5.56"}, {"G21LMG",  12000, false, ".308"}, {"XM8LMG",  12000, false, "5.56"}, {"M249",  12000, false, "5.56"}, {"K12",  12000, false, ".308"}};
	end
	if vendorsFilibusterMod then
		vendorsVehicles.vehicles.filibuster = {"Filibuster", {{"85vicsed"}, 65000}, {{"85vicwag", "85vicwag2"}, 65000}, {{"79brougham"}, 65000}, {{"volvo244"}, 65000}, {{"71impala"}, 65000}, {{"91crx"}, 65000}, {{"86yugo"}, 65000}, {{"87c10lb", "87c10sb"}, 65000}, {{"90ramlb", "90ramsb"}, 65000}, {{"87blazer"}, 65000}, {{"87suburban"}, 65000}, {{"87c10utility", "87c10mccoy", "87c10fire"}, 65000}, {{"astrovan"}, 65000}, {{"65gto"}, 65000}, {{"69charger"}, 65000}, {{"73falcon"}, 65000}, {{"77transam"}, 65000}, {{"70chevelle"}, 65000}, {{"70elcamino"}, 65000}, {{"68elcamino"}, 65000}, {{"73pinto"}, 65000}, {{"moveurself"}, 65000}, {{"isuzubox", "isuzuboxmccoy", "isuzuboxfood", "isuzuboxelec"}, 65000}, {{"hmmwvtr", "hmmwvht"}, 65000}, {{"m151canvas"}, 65000}, {{"pursuitspecial"}, 65000}, {{"51chevy3100", "51chevy3100old"}, 65000}, {{"72beetle"}, 65000}, {{"79datsun280z"}, 65000}, {{"80f350", "80f350ambulance", "80f350offroad", "80f350quad"}, 65000}, {{"83hilux", "83hiluxoffroad"}, 65000}, {{"86econoline", "86econolineambulance", "86econolinerv"}, 65000}, {{"87c10offroadlb", "87c10offroadsb"}, 65000}, {{"87caprice", "87capricePD"}, 65000}, {{"87blazeroffroad"}, 65000}, {{"90corolla"}, 65000}, {{"90ramoffroadlb", "90ramoffroadsb"}, 65000}, {{"91celica"}, 65000}, {{"91wagoneer"}, 65000}, {{"92crownvic", "92crownvicPD"}, 65000}, {{"92wrangler", "92wrangleroffroad", "92wranglerjurassic", "92wranglerranger"}, 65000}, {{"93explorer", "93explorerjurassic"}, 65000}, {{"chevystepvan", "chevystepvanswat"}, 65000}, {{"f700propane"}, 65000}, {{"m35a2fuel"}, 65000}, {{"tractorford7810"}, 65000}, {{"64mustang"}, 65000}, {{"71chevyc10stepside", "71chevyc10lb", "71chevyc10sb"}, 65000}, {{"91chevys10", "91chevys10ext", "91chevys10offroad", "91chevys10offroadext"}, 65000}, {{"93jeepcherokee"}, 65000}, {{"86montecarlo"}, 65000}, {{"71chevyc10offroadstepside", "71chevyc10offroadsb", "71chevyc10offroadlb"}, 65000}, {{"93jeepcherokeeoffroad"}, 65000}, {{"Trailer51chevy"}, 50000}, {{"Trailermovingbig"}, 1000000}, {{"Trailermovingmedium"}, 500000}, {{"Trailercamperscamp"}, 150000}, {{"Trailerfuelmedium"}, 120000}, {{"Trailerfuelsmall"}, 75000}, {{"generallee"}, 125000}};
	end
	-- if vendorsGreenFireMod then
	-- 	-- Green Fire items --------------------------------
	-- 	vendorsGreenFire = {{"KgCannabis", 4500, false}, {"OzCannabis", 100, false}, {"DryCannabisFanLeaf", 10, false, 100}, {"Hashish", 2500, false}, {"Kief", 30, false}, {"Blunt", 10, false}, {"MixedBlunt", 5, false}, {"KiefBlunt", 40, false}, {"HashBlunt", 2525, false}, {"SpaceBlunt", 2560, false}, {"CannaCigar", 45, false}, {"PreCannaCigar", 75, false}, {"DelCannaCigar", 45, false}, {"ResCannaCigar", 45, false}};
	-- end
end

function Vendors_AddGreenItem(v, container, salesTotal, dispType, item)
	local greenItemPrice = v[2];
	local greenItemMultiple = v[3];
	local greenItemQuantity = v[4];
	vendorsJewelry.green[dispType] = {};
	if greenItemQuantity then 
		vendorsJewelry.green[dispType].itemQuantity = greenItemQuantity - 1;
		vendorsJewelry.green[dispType].count = 0;
		return salesTotal;
	end
	table.insert(vendorsJewelry.green.items, {item, greenItemPrice, container, greenItemQuantity});
	vendorsJewelry.green[dispType].items = {item, greenItemPrice, container, greenItemQuantity};
	vendorsJewelry.green[dispType].count = 1;
	vendorsJewelry.green[dispType].menuCreated = false;
	salesTotal = salesTotal + greenItemPrice;
	return salesTotal;
end

function Vendors_GreenFireCheck(item, container, player, vendorsSalesTotal)
	local salesTotal = 0;
	local playerInv = player:getInventory();
	local dispType = item:getType();
	for i,v in pairs(vendorsGreenFire) do
		local greenItemQuantity = v[4];
		local greenItemPrice = v[2];
		local greenItemMultiple = v[3];
		if v[1] == item:getType() then
			if not vendorsJewelry.green[dispType] then
				salesTotal = salesTotal + Vendors_AddGreenItem(v, container, salesTotal, dispType, item)
			else
				if vendorsJewelry.green[dispType].itemQuantity then
					if vendorsJewelry.green[dispType].itemQuantity > 1 then
						vendorsJewelry.green[dispType].itemQuantity = vendorsJewelry.green[dispType].itemQuantity - 1
					else	
						table.insert(vendorsJewelry.green.items, {item, greenItemPrice, container, greenItemQuantity});
						vendorsJewelry.green[dispType].items = {item, greenItemPrice, container, greenItemQuantity};
						vendorsJewelry.green[dispType].menuCreated = false;
						vendorsJewelry.green[dispType].itemQuantity = greenItemQuantity
						vendorsJewelry.green[dispType].count = vendorsJewelry.green[dispType].count + greenItemQuantity;
						salesTotal = salesTotal + greenItemPrice;
					end
				else
					-- itemType doesn't have multiples, add 1 for every item found
					table.insert(vendorsJewelry.green.items, {item, greenItemPrice, container, greenItemQuantity});
					vendorsJewelry.green[dispType].count = vendorsJewelry.green[dispType].count + 1;
					salesTotal = salesTotal + greenItemPrice;
				end
			end
		end
	end
	table.sort(vendorsJewelry.green.items, Vendors_Compare);
	return salesTotal;
end
			
function Vendors_Compare(a,b)
  return a[1]:getName() < b[1]:getName()
end	

Events.OnLoad.Add(Vendors_CheckMods);
Events.OnFillWorldObjectContextMenu.Add(VendISWorldObjectContextMenu.createMenu);