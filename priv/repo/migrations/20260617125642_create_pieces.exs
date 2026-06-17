defmodule Tabby.Repo.Migrations.CreatePieces do
  use Ecto.Migration

  def change do
    create table(:pieces) do
      add :name, :string
      add :slug, :string
      add :type, :string
      add :instrument, :string
      add :tuning, :string
      add :contents, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:pieces, [:slug])
  end
end
