# Traders

### Formula for pricing and stock changes

#### 1. New Price Calculation

**Formula:**

```
P_new = P_current * (1 + (((S_desired - S_current) / S_desired) / S_current) * E * (1 + (2 * rand(0, 1) - 1) * V_f))
```

Where:
- `P_new`: New price.
- `P_current`: Current price.
- `S_desired`: Desired stock level.
- `S_current`: Current stock level.
- `E`: Elasticity factor.
- `V_f`: Volatility factor, ranging from 0.0 (no randomness) to 1.0 (very random).
- `rand(0, 1)`: A random value between 0 and 1.

#### 2. New Stock Level Calculation

**Formula:**

```
R_adjusted = B * ((1 - (S_current / S_desired)) / (1 + e^((S_current / S_desired) - 1))) * (1 + V_r)
```

Where:
- `R_adjusted`: Adjusted replenishment rate.
- `B`: Base replenishment rate.
- `S_current`: Current stock level.
- `S_desired`: Desired stock level.
- `e`: Euler's number (approximately 2.71828).
- `V_r`: Random volatility factor, calculated as `(2 * rand(0, 1) - 1) * V_f`.

**Volatility Factor Calculation:**

```
V_r = (2 * rand(0, 1) - 1) * V_f
```

Where:
- `V_f`: Volatility factor, ranging from 0.0 (no randomness) to 1.0 (very random).

**New Stock Calculation:**

```
S_new = S_current + R_adjusted
```

Where:
- `S_new`: New stock level.
- `S_current`: Current stock level.
