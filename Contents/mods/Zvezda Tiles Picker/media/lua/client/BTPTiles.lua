local function OnObjectLeftMouseButtonDown(object,x,y)


    local player=getPlayer()
    if isClient() and getPlayer():getAccessLevel()~="Admin" then return end
    


    if isKeyDown(Keyboard.KEY_J) then
        -- local sq = getCell():getGridSquare(x, y, z);
        -- local toRemove = {};
        -- for i=0,sq:getObjects():size()-1 do
        --     local item = sq:getObjects():get(i);
        --     table.insert(toRemove, item)
        -- end
        -- for i,v in ipairs(toRemove) do
        --     sq:RemoveTileObjectErosionNoRecalc(v);
        -- end
        if isClient() then 
            sledgeDestroy(object) 
        else
            object:getSquare():RemoveTileObjectErosionNoRecalc(object)
        
        
        end


    end

    if isKeyDown(Keyboard.KEY_K) then
        -- local sq = getCell():getGridSquare(x, y, z);
        -- local toRemove = {};
        -- for i=0,sq:getObjects():size()-1 do
        --     local item = sq:getObjects():get(i);
        --     table.insert(toRemove, item)
        -- end
        -- for i,v in ipairs(toRemove) do
        --     sq:RemoveTileObjectErosionNoRecalc(v);
        -- end

        
        local ui = ISTeleportDebugUI:new(0, 0, 300, 200, player, nil, DebugContextMenu.onTeleportValid);
	    ui:initialise();
	    ui:addToUIManager();
        


    end

    if isKeyDown(Keyboard.KEY_N) then
        -- local sq = getCell():getGridSquare(x, y, z);
        -- local toRemove = {};
        -- for i=0,sq:getObjects():size()-1 do
        --     local item = sq:getObjects():get(i);
        --     table.insert(toRemove, item)
        -- end
        -- for i,v in ipairs(toRemove) do
        --     sq:RemoveTileObjectErosionNoRecalc(v);
        -- end

        local player=getPlayer()
        if player then
            player:setZ(player:getZ()+1)
        end
        


    end

    if isKeyDown(Keyboard.KEY_M) then
        -- local sq = getCell():getGridSquare(x, y, z);
        -- local toRemove = {};
        -- for i=0,sq:getObjects():size()-1 do
        --     local item = sq:getObjects():get(i);
        --     table.insert(toRemove, item)
        -- end
        -- for i,v in ipairs(toRemove) do
        --     sq:RemoveTileObjectErosionNoRecalc(v);
        -- end

        local player=getPlayer()
        if player then
            player:setZ(player:getZ()-1)
        end
        


    end

    if isKeyDown(Keyboard.KEY_L) then
        -- local sq = getCell():getGridSquare(x, y, z);
        -- local toRemove = {};
        -- for i=0,sq:getObjects():size()-1 do
        --     local item = sq:getObjects():get(i);
        --     table.insert(toRemove, item)
        -- end
        -- for i,v in ipairs(toRemove) do
        --     sq:RemoveTileObjectErosionNoRecalc(v);
        -- end

        -- local player=getPlayer()
        -- if player then
        --     player:setZ(player:getZ()-1)
        -- end

        BetterTilePickertiles=object:getSprite():getName()
        local bo = ISBetterTilesPlace:new("", "", getPlayer());getCell():setDrag(bo, 0)
        ISBetterTilesPlace.floorSprite = IsoSprite.new()
        ISBetterTilesPlace.floorSprite:LoadFramesNoDirPageSimple(BetterTilePickertiles)

        


    end


	--print(object:getType())
	--print(getWorld():getAllTiles())
end

Events.OnObjectLeftMouseButtonDown.Add(OnObjectLeftMouseButtonDown)

-- print

BTPAlltiles={"AuthenticZ_Store","Block_Trasher","BloodFloor","BloodWalls","Bookies_Store","DylansBar01","DylansBigItems01","DylansClutter01","DylansDiorama01","DylansElectronics01","DylansFutureRoom01","DylansGardenStuff01","DylansGardenStuff02","DylansJunkstacks01","DylansJunkstacks02","DylansMotorcycles01","DylansMusicStore","DylansOvergrown01","DylansPolice01","DylansRandomFurniture01","DylansRandomFurniture02","DylansRandomFurniture03","DylansRandomFurniture04","DylansRoofs01","DylansToppledFurniture01","DylansWallDeco01","DylansWallPieces01","DylansWalls01","DylansWalls02","Dylans_Police","Obs_01","Obs_02","Obs_03","Obs_04","ZombieMapTiles","advertising_01","advertising_02","appliances_01","appliances_com_01","appliances_cooking_01","appliances_cooking_ON_01","appliances_laundry_01","appliances_misc_01","appliances_radio_01","appliances_refrigeration_01","appliances_television_01","aza_apartment_number_overlays","blends_grassoverlays_01","blends_natural_01","blends_natural_02","blends_street_01","blends_streetoverlays_01","blueprints_01","books&misc_01","books&misc_02","brokenglass_1","camping_01","carpentry_01","carpentry_02","city_deco_tk_01","city_works_tk_01","clothing_01","clothing_02","constructedobjects_01","constructedobjects_signs_01","construction_01","container_overlays_ddd_01","crafted_01","d_doors_01","d_doors_02","d_floorleaves_1","d_furniture_bedroom_01","d_furniture_bedroom_02","d_furniture_bedroom_03","d_furniture_bedroom_04","d_furniture_bedroom_05","d_furniture_couches_01","d_furniture_kitchen_01","d_generic_1","d_location_arcadian_01","d_location_sofaking","d_plants_1","d_streetcracks_1","d_trash_1","d_wall_decorations_01","d_wallcracks_1","d_walls_interior_bathroom_01","damaged_objects_01","desks_01","details_ddd_01","e_americanholly_1","e_americanlinden_1","e_canadianhemlock_1","e_carolinasilverbell_1","e_cockspurhawthorn_1","e_debug_1","e_dogwood_1","e_easternredbud_1","e_exterior_1","e_exterior_snow_1","e_newgrass_1","e_newgrassbase_1","e_newgrassbase_snow_1","e_newsnow_ground_1","e_redmaple_1","e_riverbirch_1","e_roof_snow_1","e_virginiapine_1","e_yellowwood_1","electricity_pylon","f_bushes_1","f_bushes_2","f_flowerbed_1","f_wallvines_1","fencing_01","fencing_burnt_01","fencing_damaged_01","fencing_damaged_02","fixtures_01","fixtures_bathroom_01","fixtures_bathroom_02","fixtures_counters_01","fixtures_doors_01","fixtures_doors_02","fixtures_doors_fences_01","fixtures_doors_frames_01","fixtures_escalators_01","fixtures_fireplaces_01","fixtures_overlay_counters_01","fixtures_railings_01","fixtures_sinks_01","fixtures_stairs_01","fixtures_windows_01","fixtures_windows_curtains_01","fixtures_windows_curtains_02","fixtures_windows_curtains_ddd_01","fixtures_windows_ddd_01","fixtures_windows_ddd_02","fixtures_windows_detailing_01","fixtures_windows_detailing_02","flooring_raised_02_ddd","flooring_raised_ddd","floors_burnt_01","floors_exterior_natural_01","floors_exterior_street_01","floors_exterior_tilesandstone_01","floors_interior_carpet_01","floors_interior_tilesandwood_01","floors_overlay_street_01","floors_overlay_tiles_01","floors_overlay_tiles_02","floors_overlay_wood_01","floors_rugs_01","food_01","food_02","foraging_01","furniture_bedding_01","furniture_more_ddd_01","furniture_seating_indoor_01","furniture_seating_indoor_02","furniture_seating_indoor_03","furniture_seating_outdoor_01","furniture_shelving_01","furniture_storage_01","furniture_storage_02","furniture_storage_ddd_01","furniture_tables_high_01","furniture_tables_high_ddd_01","furniture_tables_low_01","industrial_dylan","industry_01","industry_02","industry_bunker_01","industry_dirkea_ddd_01","industry_railroad_01","industry_railroad_02","industry_railroad_03","industry_railroad_04","industry_railroad_05","industry_railroad_ddd_01","industry_railroad_ddd_02","industry_tk_01","industry_tk_02","industry_trucks_01","industry_trucks_02","invisible_01","invisibles_tk_01","junkyard_tk_01","junkyard_tk_02","lighting_indoor_01","lighting_indoor_01_on","lighting_outdoor_01","lighting_outdoor_01_on","lighting_outdoor_tk_01","location_business_machinery","location_barn_01","location_business_bank_01","location_business_distillery_01","location_business_machinery_01","location_business_office_ddd_01","location_business_office_generic_01","location_community_cemetary_01","location_community_church_small_01","location_community_medical_01","location_community_park_01","location_community_police_01","location_community_school_01","location_entertainment_gallery_01","location_entertainment_gallery_02","location_entertainment_theatre_01","location_farm_accesories_01","location_farm_accesories_spyjack_01","location_hospitality_sunstarmotel_01","location_hospitality_sunstarmotel_02","location_military_generic_01","location_military_knox_01","location_military_tent_01","location_restaurant_bar_01","location_restaurant_diner_01","location_restaurant_generic_01","location_restaurant_pie_01","location_restaurant_pileocrepe_01","location_restaurant_pizzawhirled_01","location_restaurant_seahorse_01","location_restaurant_spiffos_01","location_restaurant_spiffos_02","location_restaurant_spiffos_03","location_services_beauty_01","location_sewer_01","location_shop_accessories_01","location_shop_accessories_genericsigns_01","location_shop_bargNclothes_01","location_shop_fossoil_01","location_shop_gas2go_01","location_shop_generic_01","location_shop_greenes_01","location_shop_mall_01","location_shop_mall_signs_01","location_shop_mall_signs_02","location_shop_zippee_01","location_trailer_01","location_trailer_02","office_01","overlay_blood_fence_01","overlay_blood_floor_01","overlay_blood_wall_01","overlay_graffiti_wall_01","overlay_grime_floor_01","overlay_grime_wall_01","overlay_messages_wall_01","papernotices_01","pert_walls_decayingwallpaper","preset_depthmaps_01","radio_tower","recreational_01","recreational_sports_01","roofs_01","roofs_02","roofs_03","roofs_04","roofs_05","roofs_accents_01","roofs_burnt_01","rus_industry_crane_ddd_01","seating_01","security_01","signs_miscbrands_01","signs_one-off_01","signs_one-off_02","signs_one-off_03","signs_one-off_04","signs_one-off_05","stashes_01","storage_01","street_curbs_01","street_curbs_01_blend_dark_grass","street_curbs_01_blend_dirt","street_curbs_01_blend_gravel","street_curbs_01_blend_light_grass","street_curbs_01_blend_medium_grass","street_curbs_01_blend_sand","street_curbs_01_blend_street","street_curbs_01_diag","street_curbs_01_diag_2","street_decoration_01","street_roadsigns_01","street_trafficlines_01","street_trafficlines_curb_white_faded","street_trafficlines_curb_white_full","street_trafficlines_curb_yellow_faded","street_trafficlines_curb_yellow_full","tk_porch_01","trash&junk_01","trash_01","trash_containers_tk_01","trash_walls_01","trashcontainers_01","underground_01","vegetation_farm_01","vegetation_farming_01","vegetation_foliage_01","vegetation_groundcover_01","vegetation_indoor_01","vegetation_ornamental_01","vegetation_trees_01","vegetation_wall_01","walls_burnt_01","walls_burnt_roofs_01","walls_commercial_01","walls_commercial_02","walls_commercial_03","walls_decoration_01","walls_detailing_01","walls_double_window_ddd_01","walls_exterior_house_01","walls_exterior_house_02","walls_exterior_roofs_01","walls_exterior_roofs_02","walls_exterior_roofs_03","walls_exterior_roofs_04","walls_exterior_roofs_05","walls_exterior_roofs_06","walls_exterior_roofs_07","walls_exterior_roofs_08","walls_exterior_roofs_09","walls_exterior_roofs_tk_01","walls_exterior_roofs_tk_02","walls_exterior_wooden_01","walls_exterior_wooden_02","walls_garage_01","walls_garage_02","walls_garage_tk_01","walls_house_blocks_01","walls_house_blocks_01_MIRRORED","walls_house_blocks_LIGHT_01","walls_house_blocks_LIGHT_01_MIRRORED","walls_house_brick_01","walls_house_brick_01_MIRRORED","walls_house_brick_LIGHT_01","walls_house_brick_LIGHT_01_MIRRORED","walls_house_clapboard_01","walls_house_clapboard_01_MIRRORED","walls_house_clapboard_LIGHT_01","walls_house_clapboard_LIGHT_01_MIRRORED","walls_house_flatstone_01","walls_house_flatstone_01_MIRRORED","walls_house_smooth_01","walls_house_smooth_01_MIRRORED","walls_house_stone_01","walls_house_stone_01_MIRRORED","walls_house_trailer_01","walls_house_trailer_01_MIRRORED","walls_house_wood_01","walls_house_wood_01_MIRRORED","walls_interior_bathroom_01","walls_interior_cutaways_01","walls_interior_detailing_01","walls_interior_house_01","walls_interior_house_02","walls_interior_house_03","walls_interior_house_04","walls_long_window_ddd_01","walls_special_01","weapons_01","z_templates_letterboard","z_templates_wallcutaways"}