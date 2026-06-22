// MOCK CONTACT LIST — for testing the Avatar widget
// Covers every case your detectSourceType / getInitials logic needs to handle.

class Contact {
  String name;
  String? imageSource; // can be a real image url, an asset filename, or null

  Contact({required this.name, this.imageSource});
}

List<Contact> testContacts = [
  // Normal two-word name, no image -> should show initials "HS"
  Contact(name: 'Harshii Sharma', imageSource: null),

  // Single-word name, no image -> should show initials "J"
  Contact(name: 'John', imageSource: null),

  // Empty name AND no image -> should hit your '#' fallback
  Contact(name: '', imageSource: null),

  // Has a real network image -> should load via NetworkImage
  Contact(
    name: 'Aditi Rao',
    imageSource:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
  ),

  // Has an asset image (must exist in your assets/ folder + pubspec.yaml)
  Contact(name: 'United Kingdom', imageSource: 'uk.png'),

  // Three-word name, no image -> should only use first 2 words -> "MJ"
  Contact(name: 'Mary Jane Watson', imageSource: null),

  // Name with extra/weird spacing, no image -> edge case to watch
  Contact(name: '  Ravi   Kumar  ', imageSource: null),

  // Another real network image, different person
  Contact(
    name: 'Karan Mehta',
    imageSource:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
  ),

  // No name at all is not allowed by your Contact class (name is required),
  // but imageSource is null -> tests pure initials path again
  Contact(name: 'Zara', imageSource: null),
];

// EXAMPLE — how you'd use this with your Avatar widget in a ListView:
//
// ListView.builder(
//   itemCount: testContacts.length,
//   itemBuilder: (context, index) {
//     Contact contact = testContacts[index];
//     return ListTile(
//       leading: Avatar(
//         shape: AvatarShape.circle,
//         source: contact.imageSource ?? contact.name,
//       ),
//       title: Text(contact.name),
//     );
//   },
// )
