//
//  ComplexItem.m
//  YUTableViewDemo
//
//  Created by Yücel Uzun on 04/02/14.
//  Copyright (c) 2014 Yücel Uzun. All rights reserved.
//

#import "ComplexItem.h"

@implementation ComplexItem

- (id) initWithTypeKids: (NSString *) typeKids
{
    self = [super init];
    if (self)
    {
        
        
        NSString *url_str1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/menu"];
        
        NSString *url_str = [url_str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url=[NSURL URLWithString:url_str];
        
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        NSError *error;
        
        
        NSMutableDictionary *Dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSMutableArray *arr=[Dic objectForKey:@"homepage_categories"];
         NSLog(@"Dic......%@",Dic);
//        NSMutableDictionary *dic1=[Dic objectForKey:@"67"];
//        NSMutableDictionary *dic_1=[Dic objectForKey:@"children"];
//
//        
//        NSMutableDictionary *dic2=[arr objectAtIndex:1];
//        NSMutableDictionary *dic3=[arr objectAtIndex:2];
//        NSMutableDictionary *dic4=[arr objectAtIndex:3];
//        NSMutableDictionary *dic5=[arr objectAtIndex:4];
//        NSMutableDictionary *dic6=[arr objectAtIndex:5];
//        NSMutableDictionary *dic7=[arr objectAtIndex:6];
//        NSMutableDictionary *dic8=[arr objectAtIndex:7];
//        NSMutableDictionary *dic9=[arr objectAtIndex:8];


        if ([typeKids isEqualToString:@"Clothing"])
        {
            _name1           = @"Clothing";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Boys Clothing", @"Girls Clothing", @"Baby boys Clothing", @"Baby Girls Clothing", @"Combo Packs",@"Junior’s Store"];
        }
        else if ([typeKids isEqualToString:@"Toys & Games"])
        {
            _name1           = @"Toys & Games";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"soft toys", @"Learning & Educational Toys", @"Remote control toys",@"out door toys", @"All Toys & Games", @"Puzzles", @"Toy Vehicles"];
        }
        else if ([typeKids isEqualToString:@"Footwear"])
        {
            _name1           = @"Footwear";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Boy’s Shoes", @"Girl’s Shoes"];
        }
        else if ([typeKids isEqualToString:@"Back To School"])
        {
            _name1           = @"Back To School";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Bags", @"Books & Stationary"];
        }
        else if ([typeKids isEqualToString:@"Baby Care & Maternity"])
        {
            _name1           = @"Baby Care & Maternity";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Furniture & Decor", @"Moms & Maternity", @"Baby & Kids Personal Care", @"Baby Bedding",@"Strollers and Activit gear", @"Daipering", @"Wipes", @"Feeding & Nursing"];
        }
        else if ([typeKids isEqualToString:@"Accessories"])
        {
            _name1           = @"Accessories";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Eyewear", @"Watches", @"Hair-bands, Rubber-bands & More"];
        }

    }
    return self;
}
- (id) initWithTypeArts: (NSString *) typeArts;
{
    self = [super init];
    if (self)
    {
        if ([typeArts isEqualToString:@"Home Decor"])
        {
            _name1           = @"Home Decor";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@""];
        }
        else if ([typeArts isEqualToString:@"Idols, Figurines, Puja Items"])
        {
            _name1           = @"Idols, Figurines, Puja Items";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Consectetur", @"Adipiscing", @"Elit"];
        }
        else if ([typeArts isEqualToString:@"Puja Items"])
        {
            _name1          = @"Puja Items";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Etiam", @"Id", @"Nibh", @"Eros"];
        }
        else if ([typeArts isEqualToString:@"Lamps & Lighting"])
        {
            _name1           = @"Lamps & Lighting";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Cras", @"Hendrerit", @"Convallis", @"Adipiscing"];
        }
        else if ([typeArts isEqualToString:@"Pots & Vases"])
        {
            _name1           = @"Pots & Vases";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Consectetur", @"Adipiscing", @"Elit"];
        }
        else if ([typeArts isEqualToString:@"Kitchenware"])
        {
            _name1          = @"Kitchenware";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Etiam", @"Id", @"Nibh", @"Eros"];
        }
        else if ([typeArts isEqualToString:@"Return Gifts"])
        {
            _name1           = @"Return Gifts";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Cras", @"Hendrerit", @"Convallis", @"Adipiscing"];
        }

    }
    return self;
}
- (id) initWithTypeWomen: (NSString *) typeWomen
{
    self = [super init];
    if (self)
    {
        
        if ([typeWomen isEqualToString:@"Ethnic Wear"])
        {
            _name1           = @"Ethnic Wear";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Bottom Wears",@"Dupatta Stole scarf", @"Gowns", @"Lehengas",@"Kurtas & Kurtis",@"Sarees", @"Salwar Kameez", @"Dress Materials", @"Semi Stitched Salwar Suits"];
        }
        else if ([typeWomen isEqualToString:@"Bags"])
        {
            _name1           = @"Idols, Figurines, Puja Items";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Hand bags", @"sling bags", @"wallets",@"Clutches",@"Totes"];
        }
        else if ([typeWomen isEqualToString:@"Western Wear"])
        {
            _name1          = @"Western Wear";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Tops, Tees & Shirts", @"Dresses", @"Trousers & Jeans"];
        }
        else if ([typeWomen isEqualToString:@"Beauty"])
        {
            _name1           = @"Beauty";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Herbal Care", @"Bath & Body", @"Hair Care", @"Fragrances",@"Makeup",@"Skin Care"];
        }
        else if ([typeWomen isEqualToString:@"Lingerie & Sleep Wear"])
        {
            _name1           = @"Lingerie & Sleep Wear";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Bras & Panties",@"Night Wear", @"Babydolls",@"Lingerie Sets & Bikinis"];
        }
        else if ([typeWomen isEqualToString:@"Shoes"])
        {
            _name1          = @"Shoes";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Boots", @"Sports Shoes", @"Flats", @"Heels", @"Wedges", @"Flip Flops",@"Loafer",@"Bellies"];
        }
        else if ([typeWomen isEqualToString:@"Jewellery"])
        {
            _name1           = @"Jewellery";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Neklace sets", @"Earrings", @"Rings", @"Bangles & Bracelets",@"Pendants"];
        }
        else if ([typeWomen isEqualToString:@"Whats New?"])
        {
            _name1           = @"Whats New?";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"New in clothing",@"New in Accessories", @"New in Footwear"];
        }
        else if ([typeWomen isEqualToString:@"Accessories"])
        {
            _name1          = @"Accessories";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Watches", @"Sunglasses", @"Belts"];
        }
        else if ([typeWomen isEqualToString:@"Designer Wear"])
        {
            _name1           = @"Designer Wear";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@""];
        }
        
        else if ([typeWomen isEqualToString:@"Under 499 Stores"])
        {
            _name1           = @"Under 499 Stores";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@""];
        }

        
    }
    return self;
}


- (id) initWithTypeSports: (NSString *) typeSports
{
    self = [super init];
    if (self)
    {
        
        if ([typeSports isEqualToString:@"Fitness Equipment"])
        {
            _name1           = @"Fitness Equipment";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Fitness Bands",@"Wrist & Ankle Weights", @"Accessories", @"Food & Nutrition"];
        }
        else if ([typeSports isEqualToString:@"Outdoor Sports"])
        {
            _name1           = @"Outdoor Sports";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Cricket", @"Foot Ball", @"Basketball",@"Badminton",@"Cycling",@"Swimming",@"Tennis",@"Camping & Hiking",@"Motorbike & Riding Gear"];
        }
        else if ([typeSports isEqualToString:@"Indoor Sports"])
        {
            _name1          = @"Indoor Sports";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Roller Skating", @"Board Games", @"Table Tennis",@"Hover boards",@"Skipping Ropes",@"Video Games"];
        }
        else if ([typeSports isEqualToString:@"Gym & Yoga"])
        {
            _name1           = @"Gym & Yoga";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Yoga Mats", @"Other Training Machines", @"Dumbbells", @"Abdominal Trainers",@"Exercise Balls",@"Treadmills",@"Exercise Bikes",@"Pilates"];
        }
        else if ([typeSports isEqualToString:@"Clothing & Footwear"])
        {
            _name1           = @"Clothing & Footwear";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Shaper Belts",@"Tracks & Vests", @"Sports Shoes"];
        }
        
        
    }
    return self;

}
- (id) initWithTypeBooks: (NSString *) typeBooks
{
    
    self = [super init];
    if (self)
    {
        
        if ([typeBooks isEqualToString:@"Office Stationery"])
        {
            _name1           = @"Office Stationery";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Calculators",@"Gifts", @"Files & Folders", @"Dairies & Note books",@"Office card Holders", @"Desk Organizers", @"Pens"];
        }
        else if ([typeBooks isEqualToString:@"Books"])
        {
            _name1           = @"Books";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Literature & Fiction", @"Competitive Examinations", @"Business & Management",@"Educational",@"History & Politics",@"Autobiographies & Biographies",@"Religion & Spirituality",@"All Books"];
        }
        
    }
    return self;

    
}


- (id) initWithTypeHome: (NSString *) typeHome
{
    self = [super init];
    if (self)
    {
        
        if ([typeHome isEqualToString:@"Home Decor"])
        {
            _name1           = @"Home Decor";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Photo Frames",@"Clocks", @"Wallpapers", @"Wall Decor",@"Magnets", @"Wall Stickers", @"Arts & Crafts"];
        }
        else if ([typeHome isEqualToString:@"Lighting"])
        {
            _name1           = @"Lighting";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Lamps", @"LEDs & CFLs", @"Outdoor Lights",@"Ceiling Lights"];
        }
        else if ([typeHome isEqualToString:@"Home Furnishings"])
        {
            _name1          = @"Home Furnishings";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Blankets & Quilts", @"Bed Linen", @"Bath Linen",@"Carpets & Mats",@"Cushions",@"Curtains",@"Sofa Covers",@"Cushion Covers",@"Kitchen Linen"];
        }
        else if ([typeHome isEqualToString:@"Kitchen & Dining"])
        {
            _name1           = @"Gym & Yoga";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Cookware", @"Teapots & Tea Sets", @"Dinner Sets", @"Mugs & Glassware",@"Tableware",@"Small & Large Appliances",@"Kitchen Knives & Tools"];
        }
        
        
    }
    return self;
    
}


- (id) initWithTypeMen: (NSString *) typeMen
{
    self = [super init];
    if (self)
    {

        if ([typeMen isEqualToString:@"Clothing"])
        {
            _name1           = @"Clothing";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Tracks & Sleep Wear",@"Suits & Blazers", @"Kurta sherwani& Sets", @"Jeans & Casual Trousers",@"T Shirts & Polos",@"Formal Shirts",@"Ethnic Wear", @"Shorts & 3/4ths", @"Inner Wear",@"Seasonal Wear"];
        }
        else if ([typeMen isEqualToString:@"Watches"])
        {
            _name1           = @"Watches";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Smart Watches", @"Analog", @"Digital",@"Couple Watches",@"Unisex",@"Chronograph"];
            
        }
        else if ([typeMen isEqualToString:@"Accessories"])
        {
            _name1          = @"Accessories";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Wallets", @"Socks", @"Cufflinks",@"Handkerchiefs",@"Belts",@"Ties & Suspenders",@"Pocket Squares"];
        }
        else if ([typeMen isEqualToString:@"Sunglasses"])
        {
            _name1           = @"Sunglasses";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"aviator", @"wayfarer", @"Eyewear Accessories", @"Contact Lences"];
        }
        else if ([typeMen isEqualToString:@"Grooming"])
        {
            _name1           = @"Grooming";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Fragrances",@"Shaving Creams & Gels", @"Hair",@"Skin",@"Bath & Body"];
        }
        
        else if ([typeMen isEqualToString:@"Shoes"])
        {
            _name1           = @"Shoes";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Casual Shoes", @"Formal Shoes", @"Sports Shoes", @"Flip Flops",@"sandals & Floaters", @"Ethnic Chappal", @"Kalapuri Chappal", @"Mojari",@"Sneakers", @"Loafers", @"Under 399"];
        }
        else if ([typeMen isEqualToString:@"What’s New?"])
        {
            _name1           = @"What’s New?";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"New in clothing",@"New in Shoes", @"New in Footwear"];
        }
 
    }
    return self;
    
}

- (id) initWithTypeElectronics: (NSString *) typeElectronics
{
    self = [super init];
    if (self)
    {
        
        if ([typeElectronics isEqualToString:@"Kitchen"])
        {
            _name1           = @"Kitchen";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Cookersr",@"Coffee/Tea Makers", @"Microwave Ovens", @"Mixer Juicer Grinders",@"Induction Cookers",@"Air Fryers/Deep Fryers",@"Electric Kettles"];
        }
        else if ([typeElectronics isEqualToString:@"Cameras"])
        {
            _name1           = @"Cameras";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Accessories", @"Digital Cameras", @"SLRs & DSLRs",@"Camera Lenses",@"Selfie Sticks"];
            
        }
        else if ([typeElectronics isEqualToString:@"Grooming"])
        {
            _name1          = @"Grooming";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Hair Straighteners", @"Hair Stylers", @"Body Groomers",@"Shavers",@"Hair Dryers",@"Trimmers"];
        }
        else if ([typeElectronics isEqualToString:@"Home Entertainment"])
        {
            _name1           = @"Home Entertainment";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Televisions", @"Headphones & Earphones", @"Audio & Video Accessories", @"MP3 & Media Players",@"SoundBars",@"Speakers",@"Home Theaters System"];
        }
        else if ([typeElectronics isEqualToString:@"Large Appliances"])
        {
            _name1           = @"Large Appliances";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Air Coolers",@"Air Conditioners", @"Refrigerators",@"Washing Machines & Dryers",@"Stabilizer & Inverters"];
        }
        
        else if ([typeElectronics isEqualToString:@"Computers"])
        {
            _name1           = @"Computers";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Computer Components", @"Gaming", @"Laptops", @"Desktops & Monitors",@"Storage Devices", @"Printers & Ink", @"Networking & Internet Devices", @"Accessories",@"Software", @"Office Equipment", @"Laptop Skin"];
        }
        else if ([typeElectronics isEqualToString:@"Mobiles & Tablets"])
        {
            _name1           = @"Mobiles & Tablets";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Landlines",@"Smart Phones", @"Tablets",@"Mobile Accessories",@"Cases & Covers", @"Power Banks & Memory Cards",@"All Mobiles"];
        }
        
        else if ([typeElectronics isEqualToString:@"Healthcare Appliances"])
        {
            _name1           = @"Healthcare Appliances";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Nebulizers", @"Body Fat Analyzers", @"Digital Thermometers", @"Blood Pressure Monitors",@"Massagers", @"Weighing Machines", @"Heating Pads", @"Heating Pads",@"Fitness Devices"];
        }
        else if ([typeElectronics isEqualToString:@"Home Appliances"])
        {
            _name1           = @"Home Appliances";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Fans",@"Irons", @"Vacuum Cleaners",@"Water Purifiers",@"Geysers"];
        }

        
    }
    return self;
 
}



- (id) initWithTypeOffers: (NSString *) typeOffers
{
    self = [super init];
    if (self)
    {
        
        if ([typeOffers isEqualToString:@"Clearance Sale"])
        {
            _name1           = @"Clearance Sale";
            _explenation    = @"Canis lupus familiaris";
            _randomSubitems = @[@"Fitness Bands",@"Wrist & Ankle Weights", @"Accessories", @"Food & Nutrition"];
        }
        else if ([typeOffers isEqualToString:@"Best Sellers"])
        {
            _name1           = @"Best Sellers";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Cricket", @"Foot Ball", @"Basketball",@"Badminton",@"Cycling",@"Swimming",@"Tennis",@"Camping & Hiking",@"Motorbike & Riding Gear"];
        }
        else if ([typeOffers isEqualToString:@"Under 499 Stores"])
        {
            _name1          = @"Under 499 Stores";
            _explenation    = @"Unicornis";
            _randomSubitems = @[@"Roller Skating", @"Board Games", @"Table Tennis",@"Hover boards",@"Skipping Ropes",@"Video Games"];
        }
        else if ([typeOffers isEqualToString:@"Buy 1 Get 1"])
        {
            _name1           = @"Buy 1 Get 1";
            _explenation    = @"Phoenix";
            _randomSubitems = @[@"Yoga Mats", @"Other Training Machines", @"Dumbbells", @"Abdominal Trainers",@"Exercise Balls",@"Treadmills",@"Exercise Bikes",@"Pilates"];
        }
        else if ([typeOffers isEqualToString:@"Deals of the Day"])
        {
            _name1           = @"Deals of the Day";
            _explenation    = @"Felis silvestris catus";
            _randomSubitems = @[@"Shaper Belts",@"Tracks & Vests", @"Sports Shoes"];
        }
        
        
    }
    return self;
    
}


@end
