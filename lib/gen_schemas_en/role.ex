defmodule GenSchemasEn.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias GenSchemasEn.{Permission, PermissionRole}

  @fields [:name, :description]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "roles" do
    field :description, :string
    field :name, :string

    many_to_many :permissions, Permission, join_through: PermissionRole, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:name)
  end

  def insert_permissions(role, permissions) do
    role
    |> cast(%{}, @fields)
    |> put_assoc(:permissions, permissions)
  end
end
