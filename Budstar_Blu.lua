-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
   
    mote_include_version = 2
   
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib.lua')
   end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
   
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
 
 
    blue_magic_maps = {}
   
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
   
    -- Physical Spells --
   
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }
 
    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }
 
    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
       
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
       
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
       
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }
 
    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }
 
    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }
 
    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }
 
    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }
 
    -- Magical Spells --
 
    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Spectral Floe','Tenebral Crush','Searing Tempest','Scouring Spate','Anvil Lightning'
    }
 
    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }
 
    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }
 
    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse','Entomb'
    }
 
    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
           
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
       
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }
 
    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
       
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
   
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }
 
    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
   
   
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
	state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')
 
    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
 
    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
 
    update_combat_form()
    select_default_macro_book()
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end
 
 
-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    sets.buff['Burst Affinity'] = {feet="Mavi Basmak +2"}
    sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assimilator's Charuqs"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh +1"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah +1"}
    sets.buff.Efflux = {legs="Hashishin Tayt +1", "Rosmerta's Cape"}
 
	-- Herculean --
	Herc = {}
	Herc.Head = {}
	Herc.Body = {}
	Herc.Hands = {}
	Herc.Legs = {}
	Herc.Feet = {}
	------------------
	--	Herc Head	--
	------------------
	Herc.Head.MAB = { name="Herculean Helm", augments={'Mag. Acc.+18','INT+3','"Mag.Atk.Bns."+13',}}
	Herc.Head.Acc = { name="Herculean Helm", augments={'Accuracy+26','"Triple Atk."+2','AGI+3',}}
	Herc.Head.WSD = { name="Herculean Helm", augments={'Accuracy+19','Weapon skill damage +3%','DEX+12',}}
	------------------
	--	Herc Body	--
	------------------
	
	------------------
	--	Herc Hand	--
	------------------
	Herc.Hands.TP = { name="Herculean Gloves", augments={'Accuracy+27','"Counter"+1','DEX+10','Attack+9'}}
	------------------
	--	Herc Legs	--
	------------------
	Herc.Legs.TA = { name="Herculean Trousers", augments={'CHR+8','Accuracy+16','"Triple Atk."+4'}}
	Herc.Legs.CDC = { name="Herculean Trousers", augments={'Accuracy+22','Crit. hit damage +2%','STR+7','Attack+12',}}
	------------------
	--	Herc Feet	--
	------------------
	Herc.Feet.TA = { name="Herculean Boots", augments={'Accuracy+8 Attack+8','"Triple Atk."+3','DEX+10','Attack+11',}}
	Herc.Feet.Refresh = { name="Herculean Boots", augments={'Pet: Phys. dmg. taken -1%','DEX+1','"Refresh"+2','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}
	
	-- Rosmerta --
	Rosmerta = {}
	Rosmerta.TP = { name="Rosmerta's Cape", augments={'DEX+17','Accuracy+20 Attack+20','DEX+3','"Dual Wield"+10'}}
	Rosmerta.CDC = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Crit.hit rate+10',}}
	
    -- Precast Sets
   
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}
 
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Uk'uxkaj Cap",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
       
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
   
    sets.precast.FC = {
        ammo="Impatiens",
        head="Carmine Mask",
        neck="Voltsurge Torque",
        ear1="Loquac. Earring",
        ear2="Etiolation Earring",
        body="Luhlaza Jubbah +1",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
        ring2="Weather. Ring",
        back="Swith Cape",
        waist="Witful Belt",
        legs="Ayanmo Cosciales +2",
        feet="Carmine Greaves"}
       
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
 
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Ginsen",
        head="Adhemar Bonnet",
        neck="Asperity Necklace",
        ear1="Suppanomimi",
        ear2="Brutal Earring",
        body="Adhemar Jacket",
        hands="Adhemar Wristbands",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
		legs=Herc.Legs.TA,
		feet=Herc.Feet.TA,}
   
    sets.precast.WS.acc = set_combine(sets.precast.WS, {})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Hydrocera",
        head="Jhakri Coronal +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Brutal Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        ring1="Epona's Ring",
        ring2="Rufescent Ring",
        back="Rosmerta's Cape",
        waist="Fotia Belt",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +1"})
       
    sets.precast.WS['Chant du Cygne'] = {
        ammo="Jukukik Feather",
        head="Adhemar Bonnet",
        neck="Fotia Gorget",
        ear1="Mache Earring +1",
        ear2="Mache Earring +1",
        body="Abnoba Kaftan",
        hands="Adhemar Wristbands",
        ring1="Begrudging Ring",
        ring2="Epona's Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Fotia Belt",
        legs="Samnuha Tights",
        feet="Thereoid Greaves"}
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {
        ammo="Jukukik Feather",
        head="Adhemar Bonnet",
        neck="Fotia Gorget",
        ear1="Mache Earring +1",
        ear2="Mache Earring +1",
        body="Adhemar Jacket",
        hands="Adhemar Wristbands",
        ring1="Begrudging Ring",
        ring2="Epona's Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Fotia Belt",
        legs=Herc.Legs.CDC, 
        feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','Crit. hit damage +3%','DEX+8','Accuracy+7','Attack+2',}}})
       
    sets.precast.WS['Savage Blade'] = {
        ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+19','Weapon skill damage +3%','DEX+12',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +1",
		feet={ name="Herculean Boots", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','DEX+9','Accuracy+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Apate Ring",
		right_ring="Rufescent Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {
        ammo="Mantoptera Eye",
        head=Herc.Head.WSD,
        neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Assim. Jubbah +2",
        hands="Jhakri Cuffs +2",
        ring1="Rufescent Ring",
        ring2="Epona's Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
        waist="Fotia Belt",
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','DEX+9','Accuracy+15',}}})
 
    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ghastly Tathlum +1",
        head="Jhakri Coronal +2",
        neck="Sanctity Necklace",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Jhakri Robe +2",
        hands="Amalric Gages",
        ring1="Acumen Ring",
        ring2="Strendu Ring",
        back="Izdubar Mantle",
        waist="Yamabuki-no-Obi",
        legs="Amalric Slops",
        feet="Jhakri Pigaches +1"}
   
   
    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Hasty Pinion +1",
        head="Carmine Mask",
        neck="Voltsurge Torque",
        ear1="Loquac. Earring",
        ear2="Etiolation Earring",
        body="Luhlaza Jubbah +1",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
        ring2="Weather. Ring",
        back="Swith Cape",
        waist="Witful Belt",
        legs="Ayanmo Cosciales +2",
        feet="Carmine Greaves"}
       
    sets.midcast['Blue Magic'] = {
        body="Hashishin Mintan +1"}
   
    -- Physical Spells --
   
    sets.midcast['Blue Magic'].Physical = {
        ammo="Mantoptera Eye",
        head="Jhakri Coronal +2",
        neck="Lacono Neck. +1",
        ear1="Flame Pearl",
        ear2="Flame Pearl",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        ring1="Rajas Ring",
        ring2="Strigoi Ring",
        back="Cornflower Cape",
        waist="Metalsinger Belt",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +2"}
 
    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {})
 
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)
 
 
    -- Magical Spells --
   
    sets.midcast['Blue Magic'].Magical = {
        ammo="Ghastly Tathlum +1",
        head="Jhakri Coronal +2",
        neck="Sanctity Necklace",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Jhakri Robe +2",
        hands="Amalric Gages",
        ring1="Acumen Ring",
        ring2="Strendu Ring",
        back="Cornflower Cape",
        waist="Eschan Stone",
        legs="Amalric Slops",
        feet="Jhakri Pigaches +2"}
 
    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {})
   
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {})
 
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {})
 
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicAccuracy = {
        ammo="Hydrocera",
        head="Jhakri Coronal +2",
        neck="Sanctity Necklace",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        ring1="Etana Ring",
        ring2="Sangoma Ring",
        back="Cornflower Cape",
        waist="Eschan Stone",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +2"}
 
    -- Breath Spells --
   
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
        back="Refraction Cape",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}
 
    -- Other Types --
   
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
       
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Luhlaza Keffiyeh +1",
		neck="Incanter's Torque",
		ear1="Mendi. Earring",
		ear2="Thureous Earring",
        body="Vrikodara Jupon",
		hands="Buremte Gloves",
		ring1="K'ayres Ring",
		ring2="Meridian Ring",
        back="Engulfer Cape +1",
		waist="Gishdubar Sash",
		legs="Carmine Cuisses +1",
		feet="Medium's Sabots"}
 
    sets.midcast['Blue Magic'].Healing = {
        ammo="Hydrocera",
        head="Carmine Mask",
        neck="Nuna Gorget +1",
        ear1="Mendi. Earring",
        ear2="Lifestorm Earring",
        body="Vrikodara Jupon",
        hands="Leyline Gloves",
        ring1="Aquasoul Ring",
        ring2="Rufescent Ring",
        back="Solemnity Cape",
        waist="Luminary Sash",
        legs="Carmine Cuisses +1",
        feet="Medium's Sabots"}
 
    sets.midcast['Blue Magic'].SkillBasedBuff = {
        head={ name="Luh. Keffiyeh +1", augments={'Enhances "Convergence" effect',}},
		body="Assim. Jubbah +2",
		hands="Rawhide Gloves",
		legs="Hashishin Tayt +1",
		feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},
		neck="Incanter's Torque",
		back={ name="Cornflower Cape", augments={'MP+30','DEX+3','Accuracy+5',}},
	}
 
    sets.midcast['Blue Magic'].Buff = {
        head={ name="Luh. Keffiyeh +1", augments={'Enhances "Convergence" effect',}},
		body="Assim. Jubbah +2",
		hands="Rawhide Gloves",
		legs="Hashishin Tayt +1",
		feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},
		neck="Incanter's Torque",
		back={ name="Cornflower Cape", augments={'MP+30','DEX+3','Accuracy+5',}},
	}
   
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
   
 
   
   
    -- Sets to return to when not performing an action.
 
    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {
		ammo="Staunch Tathlum",
		head={ name="Luh. Keffiyeh +1", augments={'Enhances "Convergence" effect',}},
		body="Assim. Jubbah +2",
		hands="Assim. Bazu. +2",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
 
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Resting sets
    sets.resting = {
        head="Orvail Corona",  
		neck="Eidolon Pendant +1",
        body="Chelona Blazer",
        hands="Serpentes Cuffs",
        waist="Cleric's Belt",
        back="Felicitas Cape +1",
        legs="Menhit Slacks",
        feet="Chelona Boots"}
   
    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum",
		head="Rawhide Mask",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Herculean Boots", augments={'Pet: Phys. dmg. taken -1%','DEX+1','"Refresh"+2','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
 
    sets.idle.PDT = {}
 
    sets.idle.Town = {
		ammo="Staunch Tathlum",
		head="Rawhide Mask",
		body="Jhakri Robe +2",
		hands="Serpentes Cuffs",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Herculean Boots", augments={'Pet: Phys. dmg. taken -1%','DEX+1','"Refresh"+2','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Vocane Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
 
    sets.idle.Learning = set_combine(sets.idle, sets.Learning)
 
   
    -- Defense sets
    sets.defense.PDT = {
        ammo="Staunch Tathlum",
        head={ name="Herculean Helm", augments={'Damage taken-3%','Attack+11',}},
        neck="Loricate Torque +1",
        ear1="Genmei Earring",
		ear2="Etiolation Earring",
        body="Ayanmo Corazza +2",
        hands="Assimilator's Bazubands +2",
        ring1="Defending Ring",
        ring2="Vocane Ring",
        back="Solemnity Cape",
        waist="Flume Belt +1",
        legs="Ayanmo Cosciales +2",
        feet={ name="Herculean Boots", augments={'Accuracy+25','Damage taken-2%','DEX+3',}}}
 
    sets.defense.MDT = {
        ammo="Staunch Tathlum",
        head="Dampening Tam",
        neck="Loricate Torque +1",
        ear1="Genmei Earring",
		ear2="Etiolation Earring",
        body="Ayanmo Corazza +2",
        hands="Assimilator's Bazubands +2",
        ring1="Defending Ring",
        ring2="Vocane Ring",
        back="Engulfer Cape +1",
        waist="Flume Belt +1",
        legs="Ayanmo Cosciales +2",
        feet={ name="Herculean Boots", augments={'Accuracy+25','Damage taken-2%','DEX+3',}}}
 
    sets.Kiting = {legs="Carmine Cuisses +1"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
   
    -- Normal melee group
    sets.engaged = {
        ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+8 Attack+8','"Triple Atk."+3','DEX+10','Attack+11',}},
		neck="Lissome Necklace",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.Acc = {
        ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+26','"Triple Atk."+2','AGI+3',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Herculean Boots", augments={'Accuracy+8 Attack+8','"Triple Atk."+3','DEX+10','Attack+11',}},
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.Refresh = {ammo="Jukukik Feather",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Luhlaza Jubbah +1",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Qaaxo Leggings"}
		
	 sets.engaged.PDT = {
        ammo="Staunch Tathlum",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body="Ayanmo Corazza +2",
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs="Aya. Cosciales +2",
		feet={ name="Herculean Boots", augments={'Accuracy+25','Damage taken-2%','DEX+3',}},
		neck="Loricate Torque +1",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.Acc.PDT = {
       ammo="Staunch Tathlum",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body="Ayanmo Corazza +2",
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs="Aya. Cosciales +2",
		feet={ name="Herculean Boots", augments={'Accuracy+25','Damage taken-2%','DEX+3',}},
		neck="Loricate Torque +1",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.DW = {
        ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
		feet={ name="Herculean Boots", augments={'Accuracy+8 Attack+8','"Triple Atk."+3','DEX+10','Attack+11',}},
		neck="Lissome Necklace",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.DW.Acc = {
        ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+26','"Triple Atk."+2','AGI+3',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Herculean Boots", augments={'Accuracy+8 Attack+8','"Triple Atk."+3','DEX+10','Attack+11',}},
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.DW.Refresh = {ammo="Jukukik Feather",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body="Luhlaza Jubbah +1",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Qaaxo Leggings"}
		
	 sets.engaged.DW.PDT = {
        ammo="Staunch Tathlum",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body="Ayanmo Corazza +2",
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs="Aya. Cosciales +2",
		feet={ name="Herculean Boots", augments={'Accuracy+25','Damage taken-2%','DEX+3',}},
		neck="Loricate Torque +1",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.DW.Acc.PDT = {
        ammo="Staunch Tathlum",
		head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
		body="Ayanmo Corazza +2",
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs="Aya. Cosciales +2",
		feet={ name="Herculean Boots", augments={'Accuracy+25','Damage taken-2%','DEX+3',}},
		neck="Loricate Torque +1",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
 
    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
 
 
    sets.self_healing = {hands="Buremte Gloves",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end
 
    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end