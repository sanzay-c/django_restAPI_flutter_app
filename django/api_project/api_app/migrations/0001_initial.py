# Generated by Django 5.1.3 on 2024-11-28 08:51

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Recipe',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('recipe_name', models.CharField(max_length=100)),
                ('recipe_ingridents', models.CharField(max_length=100)),
                ('recipe_description', models.TextField()),
                ('instructions', models.TextField(default=None)),
                ('cooking_time', models.IntegerField(help_text='Cooking time in minutes')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('category', models.CharField(choices=[('VEG', 'Vegetarian'), ('NON_VEG', 'Non-Vegetarian'), ('DESSERT', 'Dessert'), ('BEVERAGE', 'Beverage'), ('SNACK', 'Snack'), ('SEAFOOD', 'Seafood'), ('SALAD', 'Salad'), ('SOUP', 'Soup'), ('BREAD', 'Bread'), ('PASTA', 'Pasta'), ('GRILL', 'Grill'), ('RICE', 'Rice'), ('BREAKFAST', 'Breakfast'), ('APPETIZER', 'Appetizer'), ('MAIN_COURSE', 'Main Course'), ('ICE_CREAM', 'Ice Cream'), ('SWEET', 'Sweet'), ('VEGAN', 'Vegan'), ('GLUTEN_FREE', 'Gluten-Free'), ('KIDS_MEAL', 'Kids Meal'), ('FINGER_FOOD', 'Finger Food')], max_length=25)),
                ('recipe_image', models.ImageField(upload_to='recepie')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('recipe_name', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api_app.recipe')),
            ],
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('profile_pic', models.ImageField(blank=True, upload_to='profile_pics')),
                ('bio', models.TextField(blank=True)),
                ('dob', models.DateField(blank=True, null=True)),
                ('needs_update', models.BooleanField(default=True)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
