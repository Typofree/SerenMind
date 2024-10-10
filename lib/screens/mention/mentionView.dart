import 'package:flutter/material.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class LegalMentionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () {
            context.go('/');
          },
        ),
        title: Text(
          S.of(context).legal,
          style: AppTextStyles.headline2.copyWith(color: AppColors.textColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mentions Légales",
                  style: AppTextStyles.headline1.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Section des mentions légales
                _buildSectionTitle(
                    context, "1. Responsable du traitement des données"),
                _buildSectionContent(
                    context,
                    "Le responsable du traitement des données personnelles collectées via l'application est :\n"
                    "Nom de l'entreprise : RelaxCorp\n"
                    "Adresse : 17 Rue Ernest Hemingway, 75005 Paris\n"
                    "Email : relax.corp@wanadoo.fr\n"
                    "Numéro de téléphone : 06 89 28 62 88"),

                const SizedBox(height: 16),

                _buildSectionTitle(context, "2. Données collectées"),
                _buildSectionContent(
                    context,
                    "Dans le cadre de l'utilisation de l'application, les types de données personnelles susceptibles d'être collectées sont les suivants :\n"
                    "- Données d'identification : nom, prénom, adresse email, numéro de téléphone, etc.\n"
                    "- Données de connexion : adresse IP, journaux de connexion, etc.\n"
                    "- Données de localisation : si l'utilisateur active les services de localisation.\n"
                    "- Données techniques : modèle de l'appareil, système d'exploitation, version de l'application, etc."),

                const SizedBox(height: 16),

                _buildSectionTitle(context, "3. Finalité du traitement"),
                _buildSectionContent(
                    context,
                    "Les données personnelles collectées via l'application mobile sont traitées pour les finalités suivantes :\n"
                    "- Assurer le bon fonctionnement et la sécurité de l'application.\n"
                    "- Fournir des services personnalisés et répondre aux demandes des utilisateurs.\n"
                    "- Améliorer les fonctionnalités et l'expérience utilisateur."),

                const SizedBox(height: 16),

                _buildSectionTitle(context, "4. Base légale du traitement"),
                _buildSectionContent(
                    context,
                    "Les données personnelles sont collectées sur les bases légales suivantes :\n"
                    "- Consentement : l'utilisateur accepte expressément le traitement de ses données personnelles en utilisant l'application.\n"
                    "- Exécution du contrat : certaines données sont nécessaires pour fournir les services demandés via l'application.\n"
                    "- Obligations légales : le traitement est nécessaire pour se conformer aux obligations légales auxquelles nous sommes soumis."),

                const SizedBox(height: 16),

                _buildSectionTitle(
                    context, "5. Durée de conservation des données"),
                _buildSectionContent(
                    context,
                    "Les données personnelles collectées sont conservées pour la durée nécessaire à la réalisation des finalités décrites ci-dessus ou conformément aux obligations légales. "
                    "Les données peuvent être conservées pour une période maximale de [X années/mois] après la fin de la relation contractuelle."),

                const SizedBox(height: 16),

                _buildSectionTitle(
                    context, "6. Partage des données avec des tiers"),
                _buildSectionContent(
                    context,
                    "Les données personnelles peuvent être partagées avec les tiers suivants :\n"
                    "- Prestataires de services : sous-traitants qui nous aident à fournir l'application et ses services.\n"
                    "- Autorités publiques : lorsque cela est nécessaire pour se conformer aux obligations légales."),

                const SizedBox(height: 16),

                _buildSectionTitle(context, "7. Droits des utilisateurs"),
                _buildSectionContent(
                    context,
                    "Conformément au RGPD, les utilisateurs disposent des droits suivants concernant leurs données personnelles :\n"
                    "- Droit d'accès : obtenir des informations sur les données personnelles que nous détenons.\n"
                    "- Droit de rectification : demander la correction de données personnelles inexactes.\n"
                    "- Droit à l'effacement : demander la suppression de ses données personnelles sous certaines conditions.\n"
                    "- Droit à la limitation du traitement : limiter le traitement des données dans certains cas.\n"
                    "- Droit à la portabilité des données : recevoir ses données personnelles dans un format structuré et lisible.\n"
                    "- Droit d'opposition : s'opposer au traitement des données pour des raisons légitimes.\n\n"
                    "Pour exercer ces droits, les utilisateurs peuvent nous contacter à l'adresse suivante : [Email de contact]."),

                const SizedBox(height: 16),

                _buildSectionTitle(context, "8. Sécurité des données"),
                _buildSectionContent(context,
                    "Nous mettons en œuvre des mesures techniques et organisationnelles appropriées pour garantir la sécurité des données personnelles collectées, notamment la protection contre la destruction, la perte, l'altération ou la divulgation non autorisée de ces données."),

                const SizedBox(height: 16),

                _buildSectionTitle(
                    context, "9. Modifications des mentions légales"),
                _buildSectionContent(context,
                    "Nous nous réservons le droit de modifier les présentes mentions légales à tout moment. Les modifications seront publiées sur cette page et entreront en vigueur dès leur publication."),

                const SizedBox(height: 16),

                _buildSectionTitle(context, "10. Contact"),
                _buildSectionContent(
                    context,
                    "Pour toute question relative à la protection des données personnelles ou aux présentes mentions légales, les utilisateurs peuvent nous contacter par email à relax.corp@wanadoo.fr ou par courrier à l'adresse suivante :\n\n"
                    "RelaxCorp\n"
                    "17 Rue Ernest Hemingway, 75005 Paris\n"
                    "06 89 28 62 88"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyles.headline3.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Text(
      content,
      style: AppTextStyles.bodyText1.copyWith(
        color: AppColors.textColor,
        height:
            1.5, // Espacement entre les lignes pour une meilleure lisibilité
      ),
    );
  }
}
