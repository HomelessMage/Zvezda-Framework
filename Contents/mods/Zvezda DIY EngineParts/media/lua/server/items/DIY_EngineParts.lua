require 'Items/SuburbsDistributions'
require 'Items/ProceduralDistributions'
require 'Vehicles/VehicleDistributions'

-- Vehicle Distributions/Спавн В машинах

-- ["GloveBox/Бардачок"]
table.insert(VehicleDistributions["GloveBox"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(VehicleDistributions["GloveBox"].items, 0.5);

--Basic/Базовое

-- ["BedroomDresser/Комод в спальне"]
table.insert(ProceduralDistributions["list"]["BedroomDresser"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["BedroomDresser"].items, 2);

-- ["PlankStashMagazine/журнальный шкаф"]
table.insert(ProceduralDistributions["list"]["PlankStashMagazine"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["PlankStashMagazine"].items, 20);

-- ["OfficeDeskHome/офисный стол дома"]
table.insert(ProceduralDistributions["list"]["OfficeDeskHome"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["OfficeDeskHome"].items, 0.1);

-- ["SchoolLockers/Школьные шкафчики"]
table.insert(ProceduralDistributions["list"]["SchoolLockers"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["SchoolLockers"].items, 0.0001);

-- ["Locker/шкафчик"]
table.insert(ProceduralDistributions["list"]["Locker"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["Locker"].items, 0.5);

---CrateMagazines/Журналы в магазине
table.insert(ProceduralDistributions["list"]["CrateMagazines"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["CrateMagazines"].items, 1);

-- ["DeskGeneric/Рабочий стол"]
table.insert(ProceduralDistributions["list"]["DeskGeneric"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["DeskGeneric"].items, 0.0);

---ClassroomDesk/парта в школе
table.insert(ProceduralDistributions["list"]["ClassroomDesk"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["ClassroomDesk"].items, 0.1);

---MagazineRackMixed/стойка для журналов(смешенная)
table.insert(ProceduralDistributions["list"]["MagazineRackMixed"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["MagazineRackMixed"].items, 2);

---PostOfficeMagazines/Почтовый офис журалы
table.insert(ProceduralDistributions["list"]["PostOfficeMagazines"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["PostOfficeMagazines"].items, 0.7);

---ToolStoreBooks/Книги магазина инструментов
table.insert(ProceduralDistributions["list"]["ToolStoreBooks"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["ToolStoreBooks"].items, 20);

---side Table/тумбочка(столик)
table.insert(SuburbsDistributions["all"]["sidetable"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 1);

---post drop boxes/почтовый ящик
table.insert(SuburbsDistributions["all"]["postbox"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(SuburbsDistributions["all"]["postbox"].items, 0.25);

---Bookstore/книжный магазин
table.insert(ProceduralDistributions["list"]["BookstoreBooks"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["BookstoreBooks"].items, 5);

---LibraryBooks/Библиотечные книги
table.insert(ProceduralDistributions["list"]["LibraryBooks"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["LibraryBooks"].items, 5);

---Post office/Почтамт
table.insert(ProceduralDistributions["list"]["PostOfficeMagazines"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["PostOfficeMagazines"].items, 0.1);

---Garage/Гараж
table.insert(ProceduralDistributions["list"]["GarageMetalwork"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["GarageMetalwork"].items, 10);

---Magazine crate (found at storage lots, warehouses, etc)/Ящик для журналов (можно найти на складах, складах и т. д.)
table.insert(ProceduralDistributions["list"]["CrateMagazines"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(ProceduralDistributions["list"]["CrateMagazines"].items, 5);

---garbage bins/Мусорный контейнер
table.insert(SuburbsDistributions["all"]["bin"].items, "T15K_EngPar.DIY_EngineParts");
table.insert(SuburbsDistributions["all"]["bin"].items, 0.12);