<?php

use Illuminate\Database\Seeder;

class MunicipalitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $municipalities = [
            //Ariana
            ['name' => "Ariana Ville", 'governorate_id' => 1],
            ['name' => "Ettadhamen", 'governorate_id' => 1],
            ['name' => "Kalâat el-Andalous", 'governorate_id' => 1],
            ['name' => "La Soukra", 'governorate_id' => 1],
            ['name' => "Mnihla", 'governorate_id' => 1],
            ['name' => "Raoued", 'governorate_id' => 1],
            ['name' => "Sidi Thabet", 'governorate_id' => 1],
            //Beja
            ['name' => "Amdoun", 'governorate_id' => 2],
            ['name' => "Béja Nord", 'governorate_id' => 2],
            ['name' => "Béja Sud", 'governorate_id' => 2],
            ['name' => "Goubellat", 'governorate_id' => 2],
            ['name' => "Medjez el-Bab", 'governorate_id' => 2],
            ['name' => "Nefza", 'governorate_id' => 2],
            ['name' => "Téboursouk", 'governorate_id' => 2],
            ['name' => "Testour", 'governorate_id' => 2],
            ['name' => "Thibar", 'governorate_id' => 2],
            //Ben Arous
            ['name' => "Ben Arous", 'governorate_id' => 3],
            ['name' => "Bou Mhel el-Bassatine", 'governorate_id' => 3],
            ['name' => "El Mourouj", 'governorate_id' => 3],
            ['name' => "Ezzahra", 'governorate_id' => 3],
            ['name' => "Fouchana", 'governorate_id' => 3],
            ['name' => "Hammam Chott", 'governorate_id' => 3],
            ['name' => "Hammam Lif", 'governorate_id' => 3],
            ['name' => "Mohamedia", 'governorate_id' => 3],
            ['name' => "Medina Jedida", 'governorate_id' => 3],
            ['name' => "Mégrine", 'governorate_id' => 3],
            ['name' => "Mornag", 'governorate_id' => 3],
            ['name' => "Radès", 'governorate_id' => 3],
            //Bizerte
            ['name' => "Bizerte Nord", 'governorate_id' => 4],
            ['name' => "Bizerte Sud", 'governorate_id' => 4],
            ['name' => "El Alia", 'governorate_id' => 4],
            ['name' => "Ghar El Melh", 'governorate_id' => 4],
            ['name' => "Ghezala", 'governorate_id' => 4],
            ['name' => "Joumine", 'governorate_id' => 4],
            ['name' => "Mateur", 'governorate_id' => 4],
            ['name' => "Menzel Bourguiba", 'governorate_id' => 4],
            ['name' => "Menzel Jemil", 'governorate_id' => 4],
            ['name' => "Ras Jebel", 'governorate_id' => 4],
            ['name' => "Sejnane", 'governorate_id' => 4],
            ['name' => "Tinja", 'governorate_id' => 4],
            ['name' => "Utique", 'governorate_id' => 4],
            ['name' => "Zarzouna", 'governorate_id' => 4],
            //Gabes
            ['name' => "Gabès Médina", 'governorate_id' => 5],
            ['name' => "Gabès Ouest", 'governorate_id' => 5],
            ['name' => "Gabès Sud", 'governorate_id' => 5],
            ['name' => "Ghannouch", 'governorate_id' => 5],
            ['name' => "El Hamma", 'governorate_id' => 5],
            ['name' => "Matmata", 'governorate_id' => 5],
            ['name' => "Mareth", 'governorate_id' => 5],
            ['name' => "Menzel El Habib", 'governorate_id' => 5],
            ['name' => "Métouia", 'governorate_id' => 5],
            ['name' => "Nouvelle Matmata", 'governorate_id' => 5],
            //Gafsa
            ['name' => "Belkhir", 'governorate_id' => 6],
            ['name' => "El Guettar", 'governorate_id' => 6],
            ['name' => "El Ksar", 'governorate_id' => 6],
            ['name' => "Gafsa Nord", 'governorate_id' => 6],
            ['name' => "Gafsa Sud", 'governorate_id' => 6],
            ['name' => "Mdhilla", 'governorate_id' => 6],
            ['name' => "Métlaoui", 'governorate_id' => 6],
            ['name' => "Moularès", 'governorate_id' => 6],
            ['name' => "Redeyef", 'governorate_id' => 6],
            ['name' => "Sened", 'governorate_id' => 6],
            ['name' => "Sidi Aïch", 'governorate_id' => 6],
            //Jendouba
            ['name' => "Aïn Draham", 'governorate_id' => 7],
            ['name' => "Balta-Bou Aouane", 'governorate_id' => 7],
            ['name' => "Bou Salem", 'governorate_id' => 7],
            ['name' => "Fernana", 'governorate_id' => 7],
            ['name' => "Ghardimaou", 'governorate_id' => 7],
            ['name' => "Jendouba Sud", 'governorate_id' => 7],
            ['name' => "Jendouba Nord", 'governorate_id' => 7],
            ['name' => "Oued Meliz", 'governorate_id' => 7],
            ['name' => "Tabarka", 'governorate_id' => 7],
            //Kairouan
            ['name' => "Bou Hajla", 'governorate_id' => 8],
            ['name' => "Chebika", 'governorate_id' => 8],
            ['name' => "Echrarda", 'governorate_id' => 8],
            ['name' => "El Alâa", 'governorate_id' => 8],
            ['name' => "Haffouz", 'governorate_id' => 8],
            ['name' => "Hajeb El Ayoun", 'governorate_id' => 8],
            ['name' => "Kairouan Nord", 'governorate_id' => 8],
            ['name' => "Kairouan Sud", 'governorate_id' => 8],
            ['name' => "Nasrallah", 'governorate_id' => 8],
            ['name' => "Oueslatia", 'governorate_id' => 8],
            ['name' => "Sbikha", 'governorate_id' => 8],
            //Kasserine
            ['name' => "El Ayoun", 'governorate_id' => 9],
            ['name' => "Ezzouhour", 'governorate_id' => 9],
            ['name' => "Fériana", 'governorate_id' => 9],
            ['name' => "Foussana", 'governorate_id' => 9],
            ['name' => "Haïdr", 'governorate_id' => 9],
            ['name' => "Hassi El Ferid", 'governorate_id' => 9],
            ['name' => "Jedelienne", 'governorate_id' => 9],
            ['name' => "Kasserine Nord", 'governorate_id' => 9],
            ['name' => "Kasserine Sud", 'governorate_id' => 9],
            ['name' => "Majel Bel Abbès", 'governorate_id' => 9],
            ['name' => "Sbeïtla", 'governorate_id' => 9],
            ['name' => "Sbiba", 'governorate_id' => 9],
            ['name' => "Thala", 'governorate_id' => 9],
            //Kebili
            ['name' => "Douz Nord", 'governorate_id' => 10],
            ['name' => "Douz Sud", 'governorate_id' => 10],
            ['name' => "Faouar", 'governorate_id' => 10],
            ['name' => "Kébili Nord", 'governorate_id' => 10],
            ['name' => "Kébili Sud", 'governorate_id' => 10],
            ['name' => "Souk Lahad", 'governorate_id' => 10],
            //Kef
            ['name' => "Dahmani", 'governorate_id' => 11],
            ['name' => "Jérissa", 'governorate_id' => 11],
            ['name' => "El Ksour", 'governorate_id' => 11],
            ['name' => "Sers", 'governorate_id' => 11],
            ['name' => "Kalâat Khasb", 'governorate_id' => 11],
            ['name' => "Kalaat Senan", 'governorate_id' => 11],
            ['name' => "Kef Est", 'governorate_id' => 11],
            ['name' => "Kef Ouest", 'governorate_id' => 11],
            ['name' => "Nebeur", 'governorate_id' => 11],
            ['name' => "Sakiet Sidi Youssef", 'governorate_id' => 11],
            ['name' => "Tajerouine", 'governorate_id' => 11],
            //Mahdia
            ['name' => "Bou Merdes", 'governorate_id' => 12],
            ['name' => "Chebba", 'governorate_id' => 12],
            ['name' => "Chorbane", 'governorate_id' => 12],
            ['name' => "El Jem", 'governorate_id' => 12],
            ['name' => "Essouassi", 'governorate_id' => 12],
            ['name' => "Hebira", 'governorate_id' => 12],
            ['name' => "Ksour Essef", 'governorate_id' => 12],
            ['name' => "Mahdia", 'governorate_id' => 12],
            ['name' => "Melloulèche", 'governorate_id' => 12],
            ['name' => "Ouled Chamekh", 'governorate_id' => 12],
            ['name' => "Sidi Alouane", 'governorate_id' => 12],
            //Manouba
            ['name' => "Borj El Amri", 'governorate_id' => 13],
            ['name' => "Djedeida", 'governorate_id' => 13],
            ['name' => "Douar Hicher", 'governorate_id' => 13],
            ['name' => "El Batan", 'governorate_id' => 13],
            ['name' => "La Manouba", 'governorate_id' => 13],
            ['name' => "Mornaguia", 'governorate_id' => 13],
            ['name' => "Oued Ellil", 'governorate_id' => 13],
            ['name' => "Tebourba", 'governorate_id' => 13],
            //Médenine
            ['name' => "Ben Gardane", 'governorate_id' => 14],
            ['name' => "Beni Khedache", 'governorate_id' => 14],
            ['name' => "Djerba - Ajim", 'governorate_id' => 14],
            ['name' => "Djerba - Houmt Souk", 'governorate_id' => 14],
            ['name' => "Djerba - Midoun", 'governorate_id' => 14],
            ['name' => "Médenine Nord", 'governorate_id' => 14],
            ['name' => "Médenine Sud", 'governorate_id' => 14],
            ['name' => "Sidi Makhlouf", 'governorate_id' => 14],
            ['name' => "Zarzis", 'governorate_id' => 14],
            //Monastir
            ['name' => "Bekalta", 'governorate_id' => 15],
            ['name' => "Bembla", 'governorate_id' => 15],
            ['name' => "Beni Hassen", 'governorate_id' => 15],
            ['name' => "Jemmal", 'governorate_id' => 15],
            ['name' => "Ksar Hellal", 'governorate_id' => 15],
            ['name' => "Ksibet el-Médiouni", 'governorate_id' => 15],
            ['name' => "Moknine", 'governorate_id' => 15],
            ['name' => "Monastir", 'governorate_id' => 15],
            ['name' => "Ouerdanine", 'governorate_id' => 15],
            ['name' => "Sahline", 'governorate_id' => 15],
            ['name' => "Sayada-Lamta-Bou Hajar", 'governorate_id' => 15],
            ['name' => "Téboulba", 'governorate_id' => 15],
            ['name' => "Zéramdine", 'governorate_id' => 15],
            //Nabeul
            ['name' => "Béni Khalled", 'governorate_id' => 16],
            ['name' => "Béni Khiar", 'governorate_id' => 16],
            ['name' => "Bou Argoub", 'governorate_id' => 16],
            ['name' => "Dar Chaâbane El Fehri", 'governorate_id' => 16],
            ['name' => "El Haouaria", 'governorate_id' => 16],
            ['name' => "El Mida", 'governorate_id' => 16],
            ['name' => "Grombalia", 'governorate_id' => 16],
            ['name' => "Hammam Ghezèze", 'governorate_id' => 16],
            ['name' => "Hammamet", 'governorate_id' => 16],
            ['name' => "Kélibia", 'governorate_id' => 16],
            ['name' => "Korba", 'governorate_id' => 16],
            ['name' => "Menzel Bouzelfa", 'governorate_id' => 16],
            ['name' => "Menzel Temime", 'governorate_id' => 16],
            ['name' => "Nabeul", 'governorate_id' => 16],
            ['name' => "Soliman", 'governorate_id' => 16],
            ['name' => "Takelsa", 'governorate_id' => 16],
            //Sfax
            ['name' => "Agareb", 'governorate_id' => 17],
            ['name' => "Bir Ali Ben Khalifa", 'governorate_id' => 17],
            ['name' => "El Amra", 'governorate_id' => 17],
            ['name' => "El Hencha", 'governorate_id' => 17],
            ['name' => "Graïba", 'governorate_id' => 17],
            ['name' => "Jebiniana", 'governorate_id' => 17],
            ['name' => "Kerkennah", 'governorate_id' => 17],
            ['name' => "Mahrès", 'governorate_id' => 17],
            ['name' => "Menzel Chaker", 'governorate_id' => 17],
            ['name' => "Sakiet Eddaïer", 'governorate_id' => 17],
            ['name' => "Sakiet Ezzit", 'governorate_id' => 17],
            ['name' => "Sfax Ouest", 'governorate_id' => 17],
            ['name' => "Sfax Sud", 'governorate_id' => 17],
            ['name' => "Sfax Ville", 'governorate_id' => 17],
            ['name' => "Skhira", 'governorate_id' => 17],
            ['name' => "Thyna", 'governorate_id' => 17],
            //Sidi Bouzid
            ['name' => "Bir El Hafey", 'governorate_id' => 18],
            ['name' => "Cebbala Ouled Asker", 'governorate_id' => 18],
            ['name' => "Jilma", 'governorate_id' => 18],
            ['name' => "Meknassy", 'governorate_id' => 18],
            ['name' => "Menzel Bouzaiane", 'governorate_id' => 18],
            ['name' => "Mezzouna", 'governorate_id' => 18],
            ['name' => "Ouled Haffouz", 'governorate_id' => 18],
            ['name' => "Regueb", 'governorate_id' => 18],
            ['name' => "Sidi Ali Ben Aoun", 'governorate_id' => 18],
            ['name' => "Sidi Bouzid Est", 'governorate_id' => 18],
            ['name' => "Sidi Bouzid Ouest", 'governorate_id' => 18],
            ['name' => "Souk Jedid", 'governorate_id' => 18],
            //Siliana
            ['name' => "Bargou", 'governorate_id' => 19],
            ['name' => "Bou Arada", 'governorate_id' => 19],
            ['name' => "El Aroussa", 'governorate_id' => 19],
            ['name' => "El Krib", 'governorate_id' => 19],
            ['name' => "Gaâfour", 'governorate_id' => 19],
            ['name' => "Kesra", 'governorate_id' => 19],
            ['name' => "Makthar", 'governorate_id' => 19],
            ['name' => "Rouhia", 'governorate_id' => 19],
            ['name' => "Sidi Bou Rouis", 'governorate_id' => 19],
            ['name' => "Siliana Nord", 'governorate_id' => 19],
            ['name' => "Siliana Sud", 'governorate_id' => 19],
            //Sousse
            ['name' => "Akouda", 'governorate_id' => 20],
            ['name' => "Bouficha", 'governorate_id' => 20],
            ['name' => "Enfida", 'governorate_id' => 20],
            ['name' => "Hammam Sousse", 'governorate_id' => 20],
            ['name' => "Hergla", 'governorate_id' => 20],
            ['name' => "Kalâa Kebira", 'governorate_id' => 20],
            ['name' => "Kalâa Seghira", 'governorate_id' => 20],
            ['name' => "Kondar", 'governorate_id' => 20],
            ['name' => "M'saken", 'governorate_id' => 20],
            ['name' => "Sidi Bou Ali", 'governorate_id' => 20],
            ['name' => "Sidi El Hani", 'governorate_id' => 20],
            ['name' => "Sousse Jawhara", 'governorate_id' => 20],
            ['name' => "Sousse Médina", 'governorate_id' => 20],
            ['name' => "Sousse Riadh", 'governorate_id' => 20],
            ['name' => "Sousse Sidi Abdelhamid", 'governorate_id' => 20],
            //Tataouine
            ['name' => "Bir Lahmar", 'governorate_id' => 21],
            ['name' => "Dehiba", 'governorate_id' => 21],
            ['name' => "Ghomrassen", 'governorate_id' => 21],
            ['name' => "Remada", 'governorate_id' => 21],
            ['name' => "Smâr", 'governorate_id' => 21],
            ['name' => "Tataouine Nord", 'governorate_id' => 21],
            ['name' => "Tataouine Sud", 'governorate_id' => 21],
            //Tozeur
            ['name' => "Degache", 'governorate_id' => 22],
            ['name' => "Hazoua", 'governorate_id' => 22],
            ['name' => "Nefta", 'governorate_id' => 22],
            ['name' => "Tameghza", 'governorate_id' => 22],
            ['name' => "Tozeur", 'governorate_id' => 22],
            //Tunis
            ['name' => "Bab El Bhar", 'governorate_id' => 23],
            ['name' => "Bab Souika", 'governorate_id' => 23],
            ['name' => "Carthage", 'governorate_id' => 23],
            ['name' => "Cité El Khadra", 'governorate_id' => 23],
            ['name' => "Djebel Jelloud", 'governorate_id' => 23],
            ['name' => "El Kabaria", 'governorate_id' => 23],
            ['name' => "El Menzah", 'governorate_id' => 23],
            ['name' => "El Omrane", 'governorate_id' => 23],
            ['name' => "El Omrane supérieur", 'governorate_id' => 23],
            ['name' => "El Ouardia", 'governorate_id' => 23],
            ['name' => "Ettahrir", 'governorate_id' => 23],
            ['name' => "Ezzouhour", 'governorate_id' => 23],
            ['name' => "Hraïria", 'governorate_id' => 23],
            ['name' => "La Goulette", 'governorate_id' => 23],
            ['name' => "La Marsa", 'governorate_id' => 23],
            ['name' => "Le Bardo", 'governorate_id' => 23],
            ['name' => "Le Kram", 'governorate_id' => 23],
            ['name' => "Médina", 'governorate_id' => 23],
            ['name' => "Séjoumi", 'governorate_id' => 23],
            ['name' => "Sidi El Béchir", 'governorate_id' => 23],
            ['name' => "Sidi Hassine", 'governorate_id' => 23],
            //Zaghouan
            ['name' => "Bir Mcherga", 'governorate_id' => 24],
            ['name' => "El Fahs", 'governorate_id' => 24],
            ['name' => "Nadhour", 'governorate_id' => 24],
            ['name' => "Saouaf", 'governorate_id' => 24],
            ['name' => "Zaghouan", 'governorate_id' => 24],
            ['name' => "Zriba", 'governorate_id' => 24],

        ];
        foreach ($municipalities as $municipality) {
            DB::table('municipalities')->insert([
                'name' => $municipality['name'],
                'governorate_id' => $municipality['governorate_id'],
            ]);
        }
    }
}