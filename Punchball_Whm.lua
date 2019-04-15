-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	StatusMapK()
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets
	


    -- Fast cast sets for spells
    sets.precast.FC = {
		main="Marin Staff",
		sub="Clerisy Strap",
		ammo="Impatiens",
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Fanatic Gloves", augments={'MP+30','Healing magic skill +5','"Conserve MP"+4',}},
		legs="Aya. Cosciales +2",
		feet="Regal Pumps +1",
		neck="Orison Locket",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Defending Ring",
		right_ring="Lebeche Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		legs="Ebers Pant. +1",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring +1",
		back="Pahtli Cape",
	})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
        ammo="Hasty Pinion +1",
		head="Ayanmo Zucchetto +2",
		neck="Lissome Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring +1",
        back="Relucent Cape",
		waist="Fotia Belt",
		legs="Ayanmo Cosciales +2",
		feet="Aya. Gambieras +2"}
    
    sets.precast.WS['Flash Nova'] = {
        ammo="Hasty Pinion +1",
		head="Chironic Hat",
		neck="Fotia Gorget",
		ear1="Tati Earring +1",
		ear2="Tati Earring +1",
		body="Chironic Doublet",
		hands="Chironic Gloves",
		ring1="Levia. Ring +1",
		ring2="Levia. Ring +1",
		back="Alaunus's Cape",
		waist="Fotia Belt",
		legs="Chironic Hose",
		feet="Chironic Slippers"}
		
	sets.precast.WS['Realmrazer'] = {	
		main="Sindri",
        ammo="Hasty Pinion +1",
		head="Ayanmo Zucchetto +2",
		neck="Lissome Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring +1",
        back="Relucent Cape",
		waist="Cetl Belt",
		legs="Ayanmo Cosciales +2",
		feet="Aya. Gambieras +2"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
		main="Marin Staff",
		sub="Clerisy Strap",
		ammo="Hasty Pinion +1",
		head="Nahtirah Hat",
		body="Shango Robe",
		hands={ name="Fanatic Gloves", augments={'MP+30','Healing magic skill +5','"Conserve MP"+4',}},
		legs="Aya. Cosciales +2",
		feet="Regal Pumps +1",
		neck="Orison Locket",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Defending Ring",
		right_ring="Lebeche Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	}
    
	 sets.midcast.ConserveMP = { 
		sub="Thuellaic Ecu +1",
		ammo="Clarus Stone",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Fanatic Gloves", augments={'MP+30','Healing magic skill +5','"Conserve MP"+4',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		left_ear="Mendi. Earring",
		right_ear="Gifted Earring",
		back="Solemnity Cape",
	}
	
    -- Cure sets
    
    sets.midcast.CureSolace = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Incantor Stone",
        head="Gendewitha Caubeen",
		neck="Incanter's Torque",
		ear1="Glorious Earring",
		ear2="Nourish. Earring +1",
        body="Ebers Bliaud +1",
		hands="Theophany Mitts +2",
		ring1="Janniston Ring",
		ring2="Lebeche Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" Potency+10%'}},
		waist="Witful Belt",
		legs="Ebers Pantaloons +1",
		feet="Kaykaus Boots"}

    sets.midcast.Cure = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Incantor Stone",
        head="Gendewitha Caubeen",
		neck="Incanter's Torque",
		ear1="Glorious Earring",
		ear2="Nourish. Earring +1",
        body="Ebers Bliaud +1",
		hands="Theophany Mitts +2",
		ring1="Janniston Ring",
		ring2="Lebeche Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" Potency+10%'}},
		waist="Witful Belt",
		legs="Ebers Pantaloons +1",
		feet="Kaykaus Boots"}

    sets.midcast.Curaga = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Hydrocera",
		head="Ebers Cap +1",
		neck="Nuna Gorget +1",
		ear1="Glorious Earring",
		ear2="Nourish. Earring +1",
		body="Theo. Briault +2",
		hands="Theophany Mitts +2",
		ring1="Levia. Ring +1",
		ring2="Janniston Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" Potency+10%'}},
		waist="Rumination Sash",
		legs="Ebers Pant. +1",
		feet="Kaykaus Boots"}

    sets.midcast.CureMelee = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Incantor Stone",
        head="Gendewitha Caubeen",
		neck="Incanter's Torque",
		ear1="Glorious Earring",
		ear2="Nourish. Earring +1",
        body="Ebers Bliaud +1",
		hands="Theophany Mitts +2",
		ring1="Janniston Ring",
		ring2="Lebeche Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" Potency+10%'}},
		waist="Witful Belt",
		legs="Ebers Pantaloons +1",
		feet="Kaykaus Boots"}

    sets.midcast.Cursna = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','MND+2',}},
		sub="Thuellaic Ecu +1",
        head="Vanya Hood",
		neck="Malison Medallion",
        body="Ebers Bliaud +1",
		hands="Fanatic Gloves",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
        back="Mending Cape",
		waist="Witful Belt",
		legs="Theophany Pantaloons +2",
		feet="Vanya Clogs"}

    sets.midcast.StatusRemoval = {
		main="Yagrush",
		sub="Thuellaic Ecu +1",
		ammo="Hasty Pinion +1",
		head="Ebers Cap +1",
		body="Hedera Cotehardie",
		hands="Ebers Mitts +1",
		waist="Witful Belt",
		legs="Ebers Pant. +1",
		feet="Vanya Clogs"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
		 main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','MND+2',}},
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
		hands="Inyan. Dastanas +2",
		legs={ name="Piety Pantaln. +1", augments={'Enhances "Shellra V" effect',}},
		feet="Ebers Duckbills +1",
		neck="Incanter's Torque",
	}
		
	sets.midcast.EnhancingDuration = { 
		main="Gada",
		head="Telchine Cap",
		body="Telchine Chas.",
		hands="Telchine Gloves",
		legs="Telchine Braconi"
	}

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })
		
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
		head="Chironic Hat",
        })	

   sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet="Ebers Duckbills +1",
        })
	
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		main="Beneficus",
		head="Ebers Cap +1",
		neck="Incanter's Torque",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		ring1="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		legs="Piety Pantaln. +1",
		feet="Ebers Duckbills +1"})

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Bolelabunga",
		head="Inyanga Tiara +2",
		body={ name="Piety Briault +1", augments={'Enhances "Benediction" effect',}},
		hands="Ebers Mitts +1",
		legs="Th. Pantaloons +2",
		feet="Ebers Duckbills +1",
	})

	 sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        body="Telchine Chas.",
        hands="Ebers Mitts +1",
        legs="Th. Pant. +2",
        })
	
	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })
	
	sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Ebers Duckbills +1"
        })
	sets.midcast.Protect = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {
        feet="Piety Duckbills +1",
        ring1="Sheltered Ring",
        })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
    sets.midcast.ShellraV = set_combine(sets.midcast.Protect, {legs="Piety Pantaln. +1"})

    sets.midcast['Divine Magic'] = {
		main="Grioavolr",
		sub="Clerisy Strap +1",
		ammo="Hydrocera",
		head="Nahtirah Hat",
		neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Gwati Earring",
		body="Inyanga Jubbah +1",
		hands="Fanatic Gloves",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		waist="Luminary Sash",
		legs="Kaykaus Tights +1",
		feet="Inyan. Crackows +1"}
	
	sets.midcast.Holy = {	
		main="Grioavolr",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Chironic Hat",
		neck="Eddy Necklace",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		body="Chironic Doublet",
		hands="Chironic Gloves",
		ring1="Fenrir Ring +1",
		ring2="Fenrir Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		waist="Refoccilation Stone",
		legs="Chironic Hose",
		feet="Chironic Slippers"}
		
	sets.midcast.Banish = sets.midcast.Holy	
		
    sets.midcast['Dark Magic'] = {
		main="Bolelabunga", 
		sub="Culminus",
        head="Nahtirah Hat",
		neck="Sanctity Necklace",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
        body="Vanya Robe",
		hands="Chironic Gloves",
		ring1="Sangoma Ring",
		ring2="Perception Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		waist="Refoccilation Stone",
		legs="Inyanga Shalwar +2",
		feet="Piety Duckbills +1"}
		
	sets.midcast.Drain = {
		main="Bolelabunga",
		sub="Culminus",
		ammo="Kalboron Stone",
        head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Psystorm Earring",
		ear2="Hirudinea Earring",
        body="Vanya Robe",
		hands="Chironic Gloves",
		ring1="Sangoma Ring",
		ring2="Evanescence Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		waist="Fucho-no-Obi",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +1"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main="Grioavolr",
		sub="Enki Strap",
		ammo="Hydrocera",
		head="Chironic Hat",
		neck="Erra Pendant",
		ear1="Gwati Earring",
		ear2="Digni. Earring",
		body="Theo. Briault +3",
		hands="Kaykaus Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Theo. Duckbills +3"}

    sets.midcast.IntEnfeebles = {
		main="Grioavolr",
		sub="Enki Strap",
		ammo="Hydrocera",
		head="Chironic Hat",
		neck="Erra Pendant",
		ear1="Gwati Earring",
		ear2="Digni. Earring",
		body="Theo. Briault +3",
		hands="Kaykaus Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','"Fast Cast"+10','Mag. Acc.+20 /Mag. Dmg.+20',}},
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Theo. Duckbills +3"}

	sets.midcast.Impact = {
        main=gear.Grioavolr_MB,
        sub="Niobid Strap",
        head=empty,
        body="Twilight Cloak",
        hands="Inyan. Dastanas +2",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        ring2="Archon Ring",
        }	
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Boonwell Staff",
		ammo="Clarus Stone",
		head="Orvail Corona",
		neck="Eidolon Pendant +1",
        body="Chelona Blazer",
		hands="Nares Cuffs",
		back="Felicitas Cape +1",
        waist="Shinjutsu-no-Obi +1",
		legs="Nisse Slacks",
		feet="Chelona Boots"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Bolelabunga",
		sub="Genbu's Shield",
		ammo="Homiliary",
        head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Hearty Earring",
        body="Kaykaus Bliaut",
		hands="Chironic Gloves",
		ring1="Defending Ring",
		ring2="Fortified Ring",
        back="Solemnity Cape",
		waist="Witful Belt",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"}

    sets.idle.PDT = {
		main="Bolelabunga",
		sub="Genbu's Shield",
		ammo="Staunch Tathlum",
		head="Inyanga Tiara +2",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Hearty Earring",
		body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		ring1="Defending Ring",
		ring2="Inyanga Ring",
		back="Solemnity Cape",
		waist="Slipor Sash",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2"}

    sets.idle.Town = {
		main="Bolelabunga",
		sub="Genbu's Shield",
		ammo="Homiliary",
        head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Hearty Earring",
        body="Kaykaus Bliaut",
		hands="Chironic Gloves",
		ring1="Defending Ring",
		ring2="Fortified Ring",
        back="Solemnity Cape",
		waist="Witful Belt",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"}
    
    sets.idle.Weak = {
		main="Bolelabunga",
		sub="Genbu's Shield",
		ammo="Homiliary",
        head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Hearty Earring",
        body="Kaykaus Bliaut",
		hands="Chironic Gloves",
		ring1="Defending Ring",
		ring2="Fortified Ring",
        back="Solemnity Cape",
		waist="Witful Belt",
		legs="Tatsu. Sitagoromo",
		feet="Serpentes Sabots"}
    
    -- Defense sets

    sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
        head="Gendewitha Caubeen",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		main="Sindri",
        ammo="Hasty Pinion +1",
		head="Ayanmo Zucchetto +2",
		neck="Lissome Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring +1",
        back="Relucent Cape",
		waist="Windbuffet Belt",
		legs="Ayanmo Cosciales +2",
		feet="Aya. Gambieras +2"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}
	
	sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    Caress(spell)
	if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end 
    
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
	if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spell.name == 'Shellra V' then
            equip(sets.midcast.ShellraV)
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

function StatusMapK()
    StatusRemoval = S{'Blindna','Cursna','Erase','Esuna','Paralyna','Poisona','Sacrifice','Silena','Stona','Viruna'}
    CaressSpell = S{'Blindna','Cursna','Paralyna','Poisona','Silena','Stona','Viruna'}
end	

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function Caress(spell)
    
    if not CaressSpell:contains(spell.name) then
        return
    end
    
    local allRecasts = windower.ffxi.get_ability_recasts()
    local CaressRecast = allRecasts[32]
    
    if player.main_job_level >= 83 and CaressRecast < 1 then
        cast_delay(1.1)
        send_command('input /ja "Divine Caress" <me>')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end