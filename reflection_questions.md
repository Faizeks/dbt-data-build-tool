# Reflection Questions

## 1. Menurut Anda, apa manfaat membangun model data secara bertahap melalui staging → intermediate → mart dalam project dbt?

Menurut saya, pembagian ini membuat proses transformasi lebih rapi dan mudah dicek. Staging digunakan untuk membersihkan data, intermediate untuk join dan logika bisnis, sedangkan mart menghasilkan data yang sudah siap digunakan untuk analisis.

## 2. Apa tantangan yang Anda alami ketika membuat model dbt, dan bagaimana Anda mengatasinya selama proses pengerjaan?

Tantangan utamanya adalah memastikan hasil join dan agregasi tidak menyebabkan duplikasi data. Saya mengatasinya dengan melakukan agregasi terlebih dahulu dan membandingkan hasil transformasi dengan data staging.
