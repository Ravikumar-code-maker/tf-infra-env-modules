# tf-infra-env-modules
1️⃣ What Is a Loop? (Very Basic)

A loop means:

“Do the same thing multiple times.”

Example in real life:

If you have 3 students and you want to give each student a book.

Instead of writing:

Give book to John
Give book to Sara
Give book to Mike

You say:

For each student → give book

That is a loop.

🔹 2️⃣ What Is for_each in Terraform?

for_each is Terraform’s way of saying:

“Create one resource for every item in this list or map.”

Example:

for_each = ["dev", "test", "prod"]

Terraform will create:

Resource for dev

Resource for test

Resource for prod

Instead of writing 3 separate blocks.

🔹 3️⃣ Why Do We Need for_each?

Without for_each, you would have to write:

resource "google_compute_firewall" "rule1" { ... }

resource "google_compute_firewall" "rule2" { ... }

resource "google_compute_firewall" "rule3" { ... }

That is repetitive.

With for_each, you write ONE block and Terraform repeats it.

🔹 4️⃣ Now About Your Firewall

You defined:

variable "firewall_rules" {
  default = [
    {
      name = "allow-ssh"
      ...
    }
  ]
}

Right now you only have ONE rule.

So technically — you do NOT need a loop.

You could just write:

resource "google_compute_firewall" "rule" {
  name = "allow-ssh"
}

That would work.

🔹 So Why Use Loop Then?

Because in real projects, you may have:

[
  { name = "allow-ssh" },
  { name = "allow-http" },
  { name = "allow-https" }
]

Now you have 3 firewall rules.

Instead of writing 3 resource blocks manually,
we use:

for_each

So Terraform automatically creates all 3.

This makes the code:

Clean

Reusable

Scalable

🔹 5️⃣ Why Convert List to Map?

Good question 👏

for_each works best with a map because:

Map has:

key → value

Example:

allow-ssh → { full object }

Terraform uses the key as the internal name of the resource.

If we keep it as a list:

[
  rule1,
  rule2
]

Terraform does not have a clear unique key.

So we convert it to:

{
  allow-ssh = rule1
  allow-http = rule2
}

Now Terraform knows:

This resource is "allow-ssh"

This resource is "allow-http"

🔹 6️⃣ Very Simple Summary

Loop = repeat action
for_each = repeat resource creation
Map = gives unique names (keys)
List = just items without names

We convert list → map
So Terraform can uniquely track resources.

🔹 Final Important Answer To Your Question

You asked:

Why need map already configured allow ssh?

Answer:

You do NOT need it for one rule.

We use it so:

If tomorrow you add:

allow-http

allow-https

Terraform automatically creates them without changing resource block.

That is the real reason.

Now tell me:

Do you understand:

What a loop is?

What for_each does?

Why we convert list to map?

Tell me which one is still unclear and I’ll simplify that part even more 👌

ok now explain the code how it works

Perfect 👍 now we’ll explain exactly how your firewall code works step-by-step.

We’ll walk through it like Terraform is running it.

🔹 Your Variable
variable "firewall_rules" {
  default = [
    {
      name = "allow-ssh"
      network = "vpc-network"
      allow = [{ protocol = "tcp", ports = ["22"] }]
      source_ranges = ["0.0.0.0/0"]
    }
  ]
}

This means:

You have a list with 1 firewall rule.

Think of it like:

List:
  Rule 1:
    name = allow-ssh
🔹 Your Resource Block
resource "google_compute_firewall" "firewall" {

  for_each = { for r in var.firewall_rules : r.name => r }

  name          = each.value.name
  network       = google_compute_network.vpc.id
  allow         = each.value.allow
  source_ranges = each.value.source_ranges
}

Now let’s simulate what Terraform does.

🔹 STEP 1 — Terraform Reads the Variable

It sees:

var.firewall_rules =
[
  {
    name = "allow-ssh"
    network = "vpc-network"
    allow = [...]
    source_ranges = [...]
  }
]

This is a list.

🔹 STEP 2 — It Executes This Line
for_each = { for r in var.firewall_rules : r.name => r }

Terraform now:

Takes each rule from the list

Uses r.name as the key

Uses r as the value

So it converts the list into a map.

Result becomes:

{
  "allow-ssh" = {
    name = "allow-ssh"
    network = "vpc-network"
    allow = [...]
    source_ranges = [...]
  }
}

Now Terraform has:

KEY → VALUE

🔹 STEP 3 — Terraform Starts Looping

Because of for_each, Terraform now loops over this map.

There is only ONE key:

allow-ssh

So Terraform will create 1 firewall resource.

🔹 STEP 4 — What is each Now?

During the loop:

each.key = "allow-ssh"

each.value = {
  name = "allow-ssh"
  network = "vpc-network"
  allow = [...]
  source_ranges = [...]
}
🔹 STEP 5 — Now These Lines Run
name = each.value.name

This means:

Take the current object and get its name.

Result:

name = "allow-ssh"
allow = each.value.allow

This means:

Take the allow block from the object.

Result:

allow = [{ protocol = "tcp", ports = ["22"] }]
source_ranges = each.value.source_ranges

Result:

source_ranges = ["0.0.0.0/0"]
🔹 STEP 6 — Final Resource Created

Terraform creates:

google_compute_firewall.firewall["allow-ssh"]

With:

name = allow-ssh

allow tcp 22

source range 0.0.0.0/0

🔹 If You Had 2 Rules

If variable had:

[
  { name = "allow-ssh" },
  { name = "allow-http" }
]

Terraform would:

1️⃣ Convert to map:

{
  allow-ssh = {...}
  allow-http = {...}
}

2️⃣ Loop twice
3️⃣ Create 2 firewall resources

🔹 Why This Is Powerful

You write ONE resource block.

Terraform creates as many firewall rules as you put in the variable.

No repeated code.

🔹 Final Simple Explanation

Terraform does this:

Read list

Convert list to map

Loop over map

For each item:

each.key = rule name

each.value = rule data

Create resource

If you want, I can now show you what happens inside Terraform state so you understand why the key is important.

-----------------------------
-----------------------------
-----------------------------\
-----------------------------

Ah! Let me explain this clearly. 🙂

This line appears in Terraform when you want to create multiple resources from a list:

for_each = toset(var.bucket_names)
1️⃣ var.bucket_names

This is a variable in your module.

For example, in variables.tf:

variable "bucket_names" {
  type = list(string)
  description = "List of GCS bucket names"
}

When you call the module:

bucket_names = ["dev-bucket-1", "dev-bucket-2"]

var.bucket_names is now a list of strings:

["dev-bucket-1", "dev-bucket-2"]
2️⃣ toset()

Terraform requires a set or map for for_each.

toset() converts a list to a set of unique items.

Example:

toset(["dev-bucket-1", "dev-bucket-2", "dev-bucket-1"])

becomes:

{"dev-bucket-1", "dev-bucket-2"}   # duplicates removed

This ensures Terraform creates one resource per unique bucket.

3️⃣ for_each in resources

When you do:

resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_names)
  name     = each.value
  location = var.region
}

Terraform will create a separate bucket resource for each item in var.bucket_names.

each.value is the current bucket name.

If var.bucket_names = ["dev-bucket-1", "dev-bucket-2"]:

Terraform will create:

google_storage_bucket.buckets["dev-bucket-1"]

google_storage_bucket.buckets["dev-bucket-2"]

✅ Summary

for_each = loop over multiple items.

toset() = make the list a set (Terraform requires this for for_each).

each.value = the current item in the loop.

Result: Terraform dynamically creates multiple resources from one block.

If you want, I can rewrite your GCS module example with for_each so that you can create any number of buckets per environment without errors.
