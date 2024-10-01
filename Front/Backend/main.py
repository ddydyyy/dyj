from django.db import models

class Stock(models.Model):
    name = models.CharField(max_length=100)
    symbol = models.CharField(max_length=10, unique=True)
    price = models.FloatField()

    def __str__(self):
        return f"{self.name} ({self.symbol})"