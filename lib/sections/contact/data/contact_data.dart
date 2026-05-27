import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

class ContactLink {
  final String label;
  final String value;
  final String url;
  final IconData icon;
  final Color brandColor;

  const ContactLink({
    required this.label,
    required this.value,
    required this.url,
    required this.icon,
    required this.brandColor,
  });
}

const links = [
  ContactLink(
    label: 'Email',
    value: 'gapoljesie23@email.com',
    url: 'mailto:gapoljesie23@email.com',
    icon: Icons.email_rounded,
    brandColor: Color(0xFF6C8EBF),
  ),
  ContactLink(
    label: 'GitHub',
    value: 'github.com/bhugthicc2',
    url: 'https://github.com/bhugthicc2',
    icon: SimpleIcons.github,
    brandColor: Color(0xFF181717),
  ),
  ContactLink(
    label: 'Facebook',
    value: 'facebook.com/jesieperasgapol',
    url: 'https://facebook.com/jesieperasgapol',
    icon: SimpleIcons.facebook,
    brandColor: Color(0xFF1877F2),
  ),
];
