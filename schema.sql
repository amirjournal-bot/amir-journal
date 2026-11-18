-- امیر ژورنال: اجرا در Supabase > SQL Editor
create table public.profiles(id uuid primary key references auth.users on delete cascade,email text,is_admin boolean not null default false,created_at timestamptz default now());
create table public.journals(user_id uuid primary key references auth.users on delete cascade,data jsonb not null default '{}',updated_at timestamptz default now());

create function public.is_admin() returns boolean language sql security definer set search_path=public stable as $$select coalesce((select is_admin from public.profiles where id=auth.uid()),false)$$;
create function public.handle_new_user() returns trigger language plpgsql security definer set search_path=public as $$begin insert into public.profiles(id,email) values(new.id,new.email);return new;end$$;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();

alter table public.profiles enable row level security;
alter table public.journals enable row level security;
create policy "profile read" on public.profiles for select using(id=auth.uid() or public.is_admin());
create policy "journal read" on public.journals for select using(user_id=auth.uid() or public.is_admin());
create policy "journal insert" on public.journals for insert with check(user_id=auth.uid());
create policy "journal update" on public.journals for update using(user_id=auth.uid()) with check(user_id=auth.uid());

insert into storage.buckets(id,name,public) values('shots','shots',false) on conflict do nothing;
create policy "shots own" on storage.objects for all using(bucket_id='shots' and (storage.foldername(name))[1]=auth.uid()::text) with check(bucket_id='shots' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "shots admin read" on storage.objects for select using(bucket_id='shots' and public.is_admin());

-- بعد از ساخت حساب خودت، ادمین شو:
-- update public.profiles set is_admin=true where email='YOUR@EMAIL.COM';
