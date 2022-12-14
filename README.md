# MyPanel
## TUGAS KELOMPOK B-11 UAS

Pemrograman Berbasis Platform (CSGE602022) - diselenggarakan oleh Fakultas Ilmu Komputer Universitas Indonesia, Semester Ganjil 2022/2023

Heroku app url : [![Build status](https://build.appcenter.ms/v0.1/apps/92c8ece8-2fc3-4565-9b72-a99745390083/branches/main/badge)](https://appcenter.ms)

Heroku app deployment : [Download MyPanel](https://install.appcenter.ms/orgs/pbp-b11/apps/mypanel/distribution_groups/pbpasik123)

created by : Kelompok PBP - B11

              - Dina Dwi Kinanty (2106651650)
              - Erlangga Ahmad Khadafi (2106750894)
              - Muhammad Rifat Fadhillah (2106752470)
              - Muhammad Ruzain (2106750250)
              - Rafi Madani (2106750856)
              - Rama Tridigdaya (2106638532)

# Pendahuluan

Dewasa ini, kondisi minyak bumi di Indonesia terus menurun. Menurut Badan Pusat Statistik (BPS), cadangan minyak bumi Indonesia sebesar 4,17 miliar barel pada 2020. Hal ini menandakan bahwa minyak bumi ini meningkat 10,6% dari 2019 yaitu sebanyak 3,77 miliar barel. Namun hal ini tidak membuat kondisi minyak bumi dunia kian membaik. Oleh karena itu, kita harus terus mengembangkan energi yang ada atau biasa disebut dengan renewable energy. Banyak sumber energi yang telah dikembangkan untuk menjadi renewable energy mulai dari air, angin, maupun sinar matahari. 

Sebagai salah satu negara tropis yang dilalui oleh garis khatulistiwa, Indonesia hanya memiliki 2 musim yaitu musim hujan dan musim kemarau. Hal itu juga yang membuat indonesia selalu disinari oleh matahari setiap harinya. Memanfaatkan keadaan tersebut, kita dapat mulai mengembangkan energi terbarukan dari sinar matahari sebagai pengganti listrik yang berkaitan dengan sustainable energy transition. Penggunaan panel surya sebagai pengganti listrik dirumah dapat membantu pemilik rumah untuk menghemat pemakaian listrik dari negara sehingga biaya yang harus dikeluarkan tiap bulannya lebih murah. Namun, beberapa kendala mulai bermunculan. Salah satunya, masih banyak orang mengira bahwa penggunaan panel surya sangatlah mahal dan masih merasa bingung mengenai informasi panggunaan panel surya. Oleh karena sebab itu, kami sebagai kelompok B-11 ingin membuat aplikasi bernama 'mypanel'. 

# Pengenalan Aplikasi 

Aplikasi 'mypanel' adalah aplikasi pertama di Indonesia yang berkecimpung di bidang tenaga surya. Dalam rangka memenuhi kebutuhan solar panel di Indonesia, my panel menjadi jembatan bagi masyarakat Indonesia  dalam mencari informasi mengenai penggunaan panel surya dan memperkirakan biaya yang akan dikeluarkan untuk memasang panel surya di rumah masing-masing. Ada dua peran pengguna pada aplikasi ini, yaitu customer and technician. Customer adalah pengguna yang ingin memesan pemasangan panel surya di rumah. Sedangkan, technician adalah pengguna yang menyediakan jasa tersebut. Pengguna bisa memanfaatkan fitur-fitur modern berikut yang disediakan oleh my panel, antara lain :
  - Artikel Informatif - Dikerjakan Oleh Muhammad Ruzain (2106750250)
      
      Menyediakan informasi tentang pengguna panel surya
  - Kalkulator Panel Surya - Dikerjakan Oleh Rafi Madani (2106750856)
      
      Memberikan perkiraan biaya yang akan dikeluarkan pengguna untuk memasang panel surya yang bergantung pada luas rumah dan energi yang ingin diberikan
  - Laman Pembelian - Dikerjakan oleh Erlangga Ahmad Khadafi (2106750894)
      
      Menyediakan laman bagi calon pembeli untuk melakukan pemesanan produk yang dibutuhkan
  - Laman QNA - Dikerjakan oleh Muhammad Rifat Fadhillah (2106752470)
      
      Pengguna dapat memanfaatkan laman ini untuk bertanya mengenai fitur maupun alur yang dirasa membingungkan
  - Testimoni Pengguna - Dikerjakan Oleh Dina Dwi Kinanty (2106651650)
      
      Menyediakan laman testimoni oleh pengguna yang telah menggunakan layanan aplikasi ini dan telah menggunakan panel surya 
  - Daftar Produk    - Dikerjakan Oleh Erlangga Ahmad Khadafi (2106750894)
      
      Menyediakan laman daftar produk yang dapat dibeli 
  - Profile Pengguna - Dikerjakan Oleh Rama Tridigdaya (2106638532)
      
      Menyediakan laman edit profil pengguna
      
  - Autentikasi dan Homepage - Dikerjakan oleh Erlangga Ahmad Khadafi (2106750894) dan Muhammad Ruzain (2106750250)

# Alur Webservice
Semua modul flutter yang kami buat akan menggunakan API dan database json dari website proyek tengah semester yang sudah dibuat. Nantinya, app yang kami buat akan melakukan pengambilan data melalui GET. Dengan memanfaatkan Form, kami juga akan melakukan pengiriman data melalui method POST atau PUT dengan endpoint yang sesuai ke website proyek tengah semester kami.


