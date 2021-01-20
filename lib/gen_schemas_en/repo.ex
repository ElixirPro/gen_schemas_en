defmodule GenSchemasEn.Repo do
  use Ecto.Repo,
    otp_app: :gen_schemas_en,
    adapter: Ecto.Adapters.Postgres
end
