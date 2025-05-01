import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pet_card.dart';

class FavoritePetCardNotifier extends StateNotifier<List<PetCard>> {
  FavoritePetCardNotifier() : super([]);

  void toggleFavorite(PetCard card) {
    if (state.contains(card)) {
      state = [...state]..remove(card);
    } else {
      state = [...state, card];
    }
  }
}

final favoritePetCardsProvider =
    StateNotifierProvider<FavoritePetCardNotifier, List<PetCard>>((ref) {
  return FavoritePetCardNotifier();
});
