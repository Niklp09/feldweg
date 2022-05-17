---------------------------------------------------------------------------------------
-- decoration and building material
---------------------------------------------------------------------------------------
-- * includes a wagon wheel that can be used as decoration on walls or to build (stationary) wagons
-- * dirt road - those are more natural in small old villages than cobble roads
-- * loam - no, old buildings are usually not built out of clay; loam was used
-- * straw - useful material for roofs
-- * glass pane - an improvement compared to fence posts as windows :-)
---------------------------------------------------------------------------------------

-- supported modes:
-- * simple: only a straight dirt road; no curves, junctions etc.
-- * flat: each node is a full node; junction, t-junction and corner are included
-- * nodebox: like flat - except that each node has a nodebox that fits to that road node
-- * mesh: like nodebox - except that it uses a nice roundish model
local feldweg_feldweg_mode = minetest.settings:get("feldweg_feldweg_mode")
if(     feldweg_feldweg_mode ~= "mesh"
    and feldweg_feldweg_mode ~= "flat"
    and feldweg_feldweg_mode ~= "nodebox"
    and feldweg_feldweg_mode ~= "flat") then
	feldweg_feldweg_mode = "mesh";
    -- add the setting to the minetest.conf so that the player can set it there
    minetest.settings:set("feldweg_feldweg_mode", "mesh")
end

local function register_recipes(include_end)
	
	minetest.register_craft({
		output = "feldweg:feldweg_crossing 5",
		recipe = {
			{"", "feldweg:feldweg", "" },
			{"feldweg:feldweg", "feldweg:feldweg", "feldweg:feldweg"},
			{"", "feldweg:feldweg", "" },
		},
	})
	                                          
	minetest.register_craft({
		output = "feldweg:feldweg_t_junction 5",
		recipe = {
			{"", "feldweg:feldweg", "" },
			{"", "feldweg:feldweg", "" },
			{"feldweg:feldweg", "feldweg:feldweg", "feldweg:feldweg"}
			
		},
	})										
	             
	minetest.register_craft({
		output = "feldweg:feldweg_curve 5",
		recipe = {
			{"feldweg:feldweg", "", "" },
			{"feldweg:feldweg", "", ""},
			{"feldweg:feldweg", "feldweg:feldweg", "feldweg:feldweg"}
		},
	})									                                       
	               
	if include_end then
		minetest.register_craft({
			output = "feldweg:feldweg_end 5",
			recipe = {
				{"feldweg:feldweg", "", "feldweg:feldweg" },
				{"feldweg:feldweg", "feldweg:feldweg", "feldweg:feldweg"}
			},
		})	
	end
end

--- a nice dirt road for small villages or paths to fields
if( feldweg_feldweg_mode == "simple" or feldweg_feldweg_mode == "flat" ) then
	minetest.register_node("feldweg:feldweg", {
		description = ("dirt road"),
		tiles = {"feldweg_feldweg.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
	})
end

-- add crossing, t-junction and corner

--
-- flat - just textures, full blocks
--
if( feldweg_feldweg_mode == "flat" ) then

	minetest.register_node("feldweg:feldweg_crossing", {
		description = ("dirt road crossing"),
		tiles = {"feldweg_feldweg_kreuzung.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
	})

	minetest.register_node("feldweg:feldweg_t_junction", {
		description = ("dirt road t junction"),
		tiles = {"feldweg_feldweg_t-kreuzung.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
	})

	minetest.register_node("feldweg:feldweg_curve", {
		description = ("dirt road curve"),
		tiles = {"feldweg_feldweg_ecke.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
	})
	                                          
	register_recipes(false)
--
-- cube-style nodebox version
--
elseif( feldweg_feldweg_mode == "nodebox" ) then
	minetest.register_node("feldweg:feldweg", {
	        description = ("dirt road"),
		tiles = {"feldweg_feldweg_orig.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		roups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkanten
				{ -0.5,      0.5-2/16, -0.5,  -0.5+3/16, 0.5,  0.5},
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, -0.5,  -0.5+4/16, 0.5-1/16,  0.5},
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	minetest.register_node("feldweg:feldweg_crossing", {
		description = ("dirt road crossing"),
		tiles = {"feldweg_feldweg_kreuzung.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,

		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkanten
				{ -0.5,      0.5-2/16, -0.5,  -0.5+3/16, 0.5, -0.5+3/16},
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5, -0.5+3/16},

				{ -0.5,      0.5-2/16, 0.5-3/16,  -0.5+3/16, 0.5,  0.5},
				{  0.5-3/16, 0.5-2/16, 0.5-3/16,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, -0.5,  -0.5+4/16, 0.5-1/16, -0.5+4/16},
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16, -0.5+4/16},

				{ -0.5+3/16, 0.5-2/16, 0.5-4/16,  -0.5+4/16, 0.5-1/16,  0.5},
				{  0.5-4/16, 0.5-2/16, 0.5-4/16,   0.5-3/16, 0.5-1/16,  0.5},


				{ -0.5,      0.5-2/16, -0.5+3/16, -0.5+3/16, 0.5-1/16, -0.5+4/16},
				{  0.5-3/16, 0.5-2/16, -0.5+3/16,  0.5,      0.5-1/16, -0.5+4/16},

				{ -0.5,      0.5-2/16, 0.5-4/16,  -0.5+3/16, 0.5-1/16,  0.5-3/16},
				{  0.5-3/16, 0.5-2/16, 0.5-4/16,   0.5,      0.5-1/16,  0.5-3/16},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	minetest.register_node("feldweg:feldweg_t_junction", {
		description = ("dirt road t junction"),
		tiles = {"feldweg_feldweg_t-kreuzung.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,

		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkanten
				{ -0.5,      0.5-2/16, -0.5,  -0.5+3/16, 0.5, -0.5+3/16},

				{ -0.5,      0.5-2/16, 0.5-3/16,  -0.5+3/16, 0.5,  0.5},
				-- Rasenkante seitlich durchgehend
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, -0.5,  -0.5+4/16, 0.5-1/16, -0.5+4/16},

				{ -0.5+3/16, 0.5-2/16, 0.5-4/16,  -0.5+4/16, 0.5-1/16,  0.5},


				{ -0.5,      0.5-2/16, -0.5+3/16, -0.5+3/16, 0.5-1/16, -0.5+4/16},

				{ -0.5,      0.5-2/16, 0.5-4/16,  -0.5+3/16, 0.5-1/16,  0.5-3/16},
				-- Ueberganng seitlich durchgehend
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	minetest.register_node("feldweg:feldweg_curve", {
		description = ("dirt road curve"),
		tiles = {"feldweg_feldweg_ecke.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,

		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkante vorne durchgehend
				{ -0.5,      0.5-2/16, -0.5,  0.5-3/16, 0.5, -0.5+3/16},

				-- Rasenkanten
				{ -0.5,      0.5-2/16, 0.5-3/16,  -0.5+3/16, 0.5,  0.5},
				-- Rasenkante seitlich durchgehend
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, 0.5-4/16,  -0.5+4/16, 0.5-1/16,  0.5},


				-- Uebergang vorne durchgehend
				{ -0.5,      0.5-2/16, -0.5+3/16, 0.5-3/16, 0.5-1/16, -0.5+4/16},

				{ -0.5,      0.5-2/16, 0.5-4/16,  -0.5+3/16, 0.5-1/16,  0.5-3/16},
				-- Ueberganng seitlich durchgehend
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	register_recipes(false)                               
	                                          

--
-- the mesh version (rounded); provided and created by VanessaE
--
elseif( feldweg_feldweg_mode == "mesh" ) then

	-- a nice dirt road for small villages or paths to fields
	minetest.register_node("feldweg:feldweg", {
		description = ("dirt road"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
		tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg.obj",
	})


	minetest.register_node("feldweg:feldweg_crossing", {
		description = ("dirt road crossing"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
		tiles = {"feldweg_feldweg_end.png","default_dirt.png",
			"default_grass.png","feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg-crossing.obj",
	})


	                                          
	minetest.register_node("feldweg:feldweg_t_junction", {
		description = ("dirt road t junction"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
		tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png", "default_dirt.png",
			"default_grass.png","feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg-T-junction.obj",
	})
	                                          


	minetest.register_node("feldweg:feldweg_curve", {
		description = ("dirt road curve"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
		tiles = {"default_dirt.png^default_grass_side.png","default_grass.png",
			"default_dirt.png^default_grass_side.png","feldweg_feldweg_surface.png",
			"default_dirt.png","feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg-curve.obj",
	})


							
	minetest.register_node("feldweg:feldweg_end", {
		description = ("dirt road end"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		is_ground_content = false,
		tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png",
			"feldweg_feldweg_surface.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg_end.obj",
	})
	   
	                                          
	register_recipes(true)
 
	                                          
end

-- create stairs if possible
if( minetest.get_modpath("stairs") and stairs and stairs.register_stair_and_slab) then
	stairs.register_stair_and_slab("feldweg", "feldweg:feldweg",
		 {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		 {"feldweg_feldweg.png","default_dirt.png", "default_grass.png","default_grass.png","feldweg_feldweg.png","feldweg_feldweg.png"},
		 S("Dirt Road Stairs"),
		 S("Dirt Road, half height"),
		 feldweg.sounds.dirt)
 end
 
 if( feldweg_feldweg_mode == "nodebox" or feldweg_feldweg_mode == "mesh" ) then
		 local box_slope = {
			 type = "fixed",
			 fixed = {
				 {-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
				 {-0.5, -0.25, -0.25, 0.5,     0, 0.5},
				 {-0.5,     0,     0, 0.5,  0.25, 0.5},
				 {-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
			 }};
 
	 local box_slope_long = {
			 type = "fixed",
			 fixed = {
				 {-0.5,  -0.5,  -1.5, 0.5, -0.10, 0.5},
				 {-0.5, -0.25,  -1.3, 0.5, -0.25, 0.5},
				 {-0.5, -0.25,  -1.0, 0.5,     0, 0.5},
				 {-0.5,     0,  -0.5, 0.5,  0.25, 0.5},
				 {-0.5,  0.25,     0, 0.5,   0.5, 0.5}
			 }};
 
	 minetest.register_node("feldweg:feldweg_slope", {
		 description = ("dirt road slope"),
		 paramtype2 = "facedir",
		 groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		 legacy_facedir_simple = true,
		 groups = {crumbly=3},
		 sounds = default.node_sound_dirt_defaults(),
		 is_ground_content = false,
		 tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			 "default_dirt.png", "default_grass.png",
			 "feldweg_feldweg_surface.png",
			 "feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
		 paramtype = "light",
		 drawtype = "mesh",
		 mesh = "feldweg_slope.obj",
 
				 collision_box = box_slope,
		 selection_box = box_slope,
	 })
 
								  
											   
	 minetest.register_node("feldweg:feldweg_slope_long", {
		 description = ("dirt road slope long"),
		 paramtype2 = "facedir",
		 groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		 legacy_facedir_simple = true,
		 groups = {crumbly=3},
		 sounds = default.node_sound_dirt_defaults(),
		 is_ground_content = false,
		 tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			 "default_dirt.png", "default_grass.png",
			 "feldweg_feldweg_surface.png",
			 "feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
		 paramtype = "light",
		 drawtype = "mesh",
		 mesh = "feldweg_slope_long.obj",
				 collision_box = box_slope_long,
		 selection_box = box_slope_long,
	 })
			 
											   
	 minetest.register_craft({
		 output = "feldweg:feldweg_slope 3",
		 recipe = {
			 {"feldweg:feldweg", "", "" },
			 {"feldweg:feldweg", "feldweg:feldweg", ""}
		 },
	 })	     
											   
	 minetest.register_craft({
		 output = "feldweg:feldweg_slope_long 4",
		 recipe = {
			 {"feldweg:feldweg", "", "" },
			 {"feldweg:feldweg", "feldweg:feldweg", "feldweg:feldweg"}
		 },
	 })
 end
 