/*
  # Create initial users and profiles

  1. New Users
    - Manager user (khelfk31@gmail.com)
    - Employee user (funcionariok31@gmail.com)
  2. Security
    - Users are created with hashed passwords
    - Profiles are created with appropriate roles
*/

-- Create manager user if not exists
INSERT INTO auth.users (
  id,
  email,
  raw_user_meta_data,
  raw_app_meta_data,
  is_super_admin,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  aud,
  role
)
SELECT 
  uuid_generate_v4(),
  'khelfk31@gmail.com',
  '{}'::jsonb,
  '{"provider":"email","providers":["email"]}'::jsonb,
  FALSE,
  crypt('admin123', gen_salt('bf')),
  now(),
  now(),
  now(),
  'authenticated',
  'authenticated'
WHERE NOT EXISTS (
  SELECT 1 FROM auth.users WHERE email = 'khelfk31@gmail.com'
);

-- Create employee user if not exists
INSERT INTO auth.users (
  id,
  email,
  raw_user_meta_data,
  raw_app_meta_data,
  is_super_admin,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  aud,
  role
)
SELECT 
  uuid_generate_v4(),
  'funcionariok31@gmail.com',
  '{}'::jsonb,
  '{"provider":"email","providers":["email"]}'::jsonb,
  FALSE,
  crypt('fun123', gen_salt('bf')),
  now(),
  now(),
  now(),
  'authenticated',
  'authenticated'
WHERE NOT EXISTS (
  SELECT 1 FROM auth.users WHERE email = 'funcionariok31@gmail.com'
);

-- Create manager profile
INSERT INTO user_profiles (id, role, name)
SELECT id, 'manager', 'Gerente Khelf'
FROM auth.users
WHERE email = 'khelfk31@gmail.com'
AND NOT EXISTS (
  SELECT 1 FROM user_profiles WHERE id = auth.users.id
);

-- Create employee profile
INSERT INTO user_profiles (id, role, name)
SELECT id, 'employee', 'Funcionário Khelf'
FROM auth.users
WHERE email = 'funcionariok31@gmail.com'
AND NOT EXISTS (
  SELECT 1 FROM user_profiles WHERE id = auth.users.id
);