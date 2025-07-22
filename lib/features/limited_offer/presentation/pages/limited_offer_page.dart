import 'package:flutter/material.dart';

class LimitedOfferPage extends StatefulWidget {
  const LimitedOfferPage({super.key});

  @override
  State<LimitedOfferPage> createState() => _LimitedOfferPageState();
}

class _LimitedOfferPageState extends State<LimitedOfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D1B2E),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A2E4D), Color(0xFF2D1B2E)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Başlık
                const Text(
                  'Sınırlı Teklif',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Alt başlık
                const Text(
                  'Jeton paketin\'ni seçerek bonus\nkazanın ve yeni bölümlerin kilidini açın!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFB8A9B8), fontSize: 16),
                ),

                const SizedBox(height: 30),

                // Bonus özellikler
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Alacağınız Bonuslar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildBonusItem(
                            icon: Icons.diamond_outlined,
                            title: 'Premium\nHesap',
                            color: const Color(0xFFE91E63),
                          ),
                          _buildBonusItem(
                            icon: Icons.favorite_outline,
                            title: 'Daha\nFazla Eşleşme',
                            color: const Color(0xFFE91E63),
                          ),
                          _buildBonusItem(
                            icon: Icons.arrow_upward,
                            title: 'Öne\nÇıkarma',
                            color: const Color(0xFFE91E63),
                          ),
                          _buildBonusItem(
                            icon: Icons.favorite,
                            title: 'Daha\nFazla Beğeni',
                            color: const Color(0xFFE91E63),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Jeton paketleri başlığı
                const Text(
                  'Kilidi açmak için bir jeton paketi seçin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                // Jeton paketleri
                Row(
                  children: [
                    Expanded(
                      child: _buildJetonPaketi(
                        bonus: '+10%',
                        eskiFiyat: '200',
                        yeniFiyat: '330',
                        jeton: 'Jeton',
                        fiyat: '₺99,99',
                        altBaslik: 'Başına haftalık',
                        bonusColor: const Color(0xFFE57373),
                        backgroundColor: const Color(0xFFB71C1C),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildJetonPaketi(
                        bonus: '+70%',
                        eskiFiyat: '2.000',
                        yeniFiyat: '3.375',
                        jeton: 'Jeton',
                        fiyat: '₺799,99',
                        altBaslik: 'Başına haftalık',
                        bonusColor: const Color(0xFF9C27B0),
                        backgroundColor: const Color(0xFF7B1FA2),
                        isPopular: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildJetonPaketi(
                        bonus: '+35%',
                        eskiFiyat: '1.000',
                        yeniFiyat: '1.350',
                        jeton: 'Jeton',
                        fiyat: '₺399,99',
                        altBaslik: 'Başına haftalık',
                        bonusColor: const Color(0xFFE57373),
                        backgroundColor: const Color(0xFFB71C1C),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Satın al butonu
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Satın alma işlemi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Tüm Jetonları Gör',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBonusItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3), width: 2),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildJetonPaketi({
    required String bonus,
    required String eskiFiyat,
    required String yeniFiyat,
    required String jeton,
    required String fiyat,
    required String altBaslik,
    required Color bonusColor,
    required Color backgroundColor,
    bool isPopular = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [backgroundColor, backgroundColor.withOpacity(0.8)],
        ),
      ),
      child: Column(
        children: [
          // Bonus etiketi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: bonusColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Text(
              bonus,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // İçerik
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Eski fiyat (üstü çizili)
                Text(
                  eskiFiyat,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 5),

                // Yeni fiyat
                Text(
                  yeniFiyat,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Jeton
                Text(
                  jeton,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 15),

                // Fiyat
                Text(
                  fiyat,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Alt başlık
                Text(
                  altBaslik,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
