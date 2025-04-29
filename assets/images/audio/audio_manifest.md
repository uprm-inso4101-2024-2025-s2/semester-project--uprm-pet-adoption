# Audio Manifest for Pet Adoption App

## Background Music
- pets_music_intro_theme.mp3 → Calm shelter background music (Pixabay, Free for Commercial Use)
- funny_pets_intro_theme.mp3 → Playful pet intro music (Pixabay, Free for Commercial Use)
- cute_cat_theme.mp3 → Soft and sweet pet-friendly theme (Pixabay, Free for Commercial Use)
- background_loading.mp3 → Calm soft ambient loop for potential loading screens (Mixkit, Free for Commercial Use)

## Sound Effects
- click_widget_1.wav → Soft subtle tap click for widget interaction (Mixkit, Free for Commercial Use)
- click_widget_2.wav → Crisp soft button click alternative (Mixkit, Free for Commercial Use)
- swipe_card_1.wav → Gentle swoosh for PetCard swipe (Mixkit, Free for Commercial Use)
- swipe_card_2.wav → Quick clean swoosh alternative for PetCard swipe (Mixkit, Free for Commercial Use)

## Notes
- All audio files are royalty-free and suitable for commercial applications.
- Sources: Pixabay and Mixkit.
- No attribution required by license terms.
- Audio assets are organized under: `assets/audio/background/` and `assets/audio/sfx/`

## Integration Instructions
To use an audio asset in the app:

1. Register the asset path in `pubspec.yaml` under the `flutter/assets` section.
2. Use an audio playback library like `just_audio` or `audioplayers` to load and play the asset.

Example using `audioplayers`:
```dart
final player = AudioPlayer();
await player.play(AssetSource('audio/background/pets_music_intro_theme.mp3'));