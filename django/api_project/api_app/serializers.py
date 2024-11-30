from rest_framework import serializers
from .models import *

class RecipeSerializer(serializers.ModelSerializer):
    user = serializers.CharField(source='user.username') 
    class Meta:
        model = Recipe
        fields = '__all__'

    def to_representation(self, instance):
        # Call the parent method to get the original representation
        representation = super().to_representation(instance)
        
        # Modify the 'category' field to return the human-readable version
        # Using dict(choices) to get the human-readable value
        category_display = dict(Recipe.CATEGORY_CHOICES).get(instance.category, instance.category)
        representation['category'] = category_display
        
        return representation

class CommentSerializer(serializers.ModelSerializer):
    user = serializers.CharField(source='user.username') 
    class Meta:
        model = Comment
        fields = '__all__'

class UserProfileSerializer(serializers.ModelSerializer):
    user = serializers.CharField(source='user.username') 
    class Meta:
        model = UserProfile
        fields = '__all__'  # Explicitly include fields, excluding 'id'
